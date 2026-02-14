// =============================================================================
// Todo Provider
// =============================================================================
// Concepts demonstrated:
// - Complex ChangeNotifier managing list + pagination + loading states
// - Optimistic updates with rollback on error
// - Consumer vs Provider.of — when to use each
// - listen: true vs listen: false in Provider.of
// - Working with nested models and lists
// - Pattern: calling notifyListeners() to trigger selective UI rebuilds
//
// Consumer vs Provider.of:
// -------------------------
// Consumer<TodoProvider>(
//   builder: (context, todoProvider, child) => Text(todoProvider.todos.length),
// )
// → Rebuilds ONLY this widget when TodoProvider changes.
// → Use inside build() for UI that displays provider state.
//
// Provider.of<TodoProvider>(context, listen: false)
// → Does NOT rebuild when provider changes.
// → Use in event handlers (onPressed, initState) to call methods.
//
// Provider.of<TodoProvider>(context, listen: true)  [or just Provider.of<...>(context)]
// → Rebuilds the entire build() method when provider changes.
// → Rarely preferred over Consumer because it's less precise.
//
// Provider.value example (commented out):
// -------------------------
// If you already have an instance and want to provide it without creating:
// Provider.value(
//   value: existingInstance,
//   child: ...,
// )
// =============================================================================

import 'package:flutter/foundation.dart'; // ChangeNotifier

import '../models/todo_detail.dart';
import '../models/todo_summary.dart';
import '../services/api_service.dart';

/// Manages todo CRUD operations, pagination, and loading states.
///
/// This provider is more complex than [AuthProvider] because it manages
/// a *list* of items with pagination, plus a separate detail view.
class TodoProvider extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Dependencies
  // ---------------------------------------------------------------------------

  /// The API service used for all HTTP requests.
  final ApiService _apiService = ApiService();

  // ---------------------------------------------------------------------------
  // List state
  // ---------------------------------------------------------------------------

  /// The current list of todo summaries (for list/grid views).
  List<TodoSummary> _todos = [];

  /// The current page number (1-based).
  int _currentPage = 1;

  /// The total number of todos across all pages.
  int _totalItems = 0;

  /// The page size used for fetching.
  final int _pageSize = 10;

  /// Whether a list-fetch is in progress.
  bool _isLoading = false;

  /// Whether more pages are available.
  bool _hasMore = true;

  // ---------------------------------------------------------------------------
  // Detail state
  // ---------------------------------------------------------------------------

  /// The currently viewed todo detail, or null.
  TodoDetail? _selectedTodo;

  /// Whether a detail-fetch is in progress.
  bool _isLoadingDetail = false;

  // ---------------------------------------------------------------------------
  // Error state
  // ---------------------------------------------------------------------------

  /// The error message from the last failed operation, or null.
  String? _errorMessage;

  // ---------------------------------------------------------------------------
  // Getters
  // ---------------------------------------------------------------------------

  /// The list of todos for the current view.
  List<TodoSummary> get todos => _todos;

  /// Current page number.
  int get currentPage => _currentPage;

  /// Total items across all pages.
  int get totalItems => _totalItems;

  /// Whether a list-fetch is in progress.
  bool get isLoading => _isLoading;

  /// Whether more pages can be loaded.
  bool get hasMore => _hasMore;

  /// The currently selected todo detail.
  TodoDetail? get selectedTodo => _selectedTodo;

  /// Whether a detail-fetch is in progress.
  bool get isLoadingDetail => _isLoadingDetail;

  /// The last error message.
  String? get errorMessage => _errorMessage;

  /// Whether the list is empty and not loading.
  bool get isEmpty => _todos.isEmpty && !_isLoading;

  // ---------------------------------------------------------------------------
  // List operations
  // ---------------------------------------------------------------------------

  /// Fetches a page of todos from the API.
  ///
  /// [token] — JWT bearer token for authentication.
  /// [page] — the page number to fetch (defaults to 1).
  ///
  /// If [page] is 1, the list is replaced (fresh load).
  /// If [page] > 1, the results are appended (infinite scroll).
  Future<void> fetchTodos(String token, {int page = 1}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.fetchTodos(
        token,
        page: page,
        pageSize: _pageSize,
      );

      if (page == 1) {
        // First page — replace the entire list.
        _todos = response.todos;
      } else {
        // Subsequent pages — append to existing list.
        _todos = [..._todos, ...response.todos];
      }

      _currentPage = response.page;
      _totalItems = response.total;
      _hasMore = response.hasMore;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
    }
  }

  /// Loads the next page of todos (infinite scroll).
  ///
  /// Does nothing if already loading or no more pages available.
  Future<void> loadNextPage(String token) async {
    if (_isLoading || !_hasMore) return;
    await fetchTodos(token, page: _currentPage + 1);
  }

  /// Refreshes the list by re-fetching page 1.
  ///
  /// Used by RefreshIndicator (pull-to-refresh).
  Future<void> refreshTodos(String token) async {
    await fetchTodos(token, page: 1);
  }

  // ---------------------------------------------------------------------------
  // Detail operations
  // ---------------------------------------------------------------------------

  /// Fetches the full detail for a single todo.
  Future<void> fetchTodoDetail(String token, int id) async {
    _isLoadingDetail = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _selectedTodo = await _apiService.fetchTodoDetail(token, id);
      _isLoadingDetail = false;
      notifyListeners();
    } catch (e) {
      _isLoadingDetail = false;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
    }
  }

  /// Clears the selected todo (e.g., when navigating away).
  void clearSelectedTodo() {
    _selectedTodo = null;
    // No notifyListeners() needed — the screen is being disposed anyway.
  }

  // ---------------------------------------------------------------------------
  // Create
  // ---------------------------------------------------------------------------

  /// Creates a new todo and refreshes the list.
  ///
  /// Returns `true` on success, `false` on failure.
  Future<bool> addTodo(
    String token, {
    required String title,
    String? description,
    String? iconUrl,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _apiService.createTodo(
        token,
        title: title,
        description: description,
        iconUrl: iconUrl,
      );

      // Refresh the list to include the new item.
      await fetchTodos(token, page: 1);
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Update
  // ---------------------------------------------------------------------------

  /// Toggles the checked state of a todo.
  ///
  /// Uses **optimistic update**: the UI is updated immediately, and if the
  /// API call fails, the change is rolled back.
  ///
  /// Optimistic updates make the app feel snappy because the user sees
  /// the result instantly rather than waiting for the server response.
  Future<void> toggleChecked(String token, int id, bool currentValue) async {
    // 1. Find the item in the list.
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;

    // 2. Save the old value for rollback.
    final oldTodo = _todos[index];

    // 3. Optimistically update the UI.
    _todos[index] = TodoSummary(
      id: oldTodo.id,
      title: oldTodo.title,
      checked: !currentValue, // Flip the value
      thumbnail: oldTodo.thumbnail,
    );
    notifyListeners(); // UI updates immediately

    try {
      // 4. Send the update to the server.
      await _apiService.updateTodo(token, id, checked: !currentValue);
    } catch (e) {
      // 5. Rollback on failure — restore the old value.
      _todos[index] = oldTodo;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
    }
  }

  /// Updates a todo with new values.
  ///
  /// Returns `true` on success.
  Future<bool> updateTodo(
    String token,
    int id, {
    String? title,
    String? description,
    bool? checked,
    String? iconUrl,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updated = await _apiService.updateTodo(
        token,
        id,
        title: title,
        description: description,
        checked: checked,
        iconUrl: iconUrl,
      );

      // Update the selected detail if we're viewing this todo.
      if (_selectedTodo?.id == id) {
        _selectedTodo = updated;
      }

      // Refresh the list to reflect changes.
      await fetchTodos(token, page: 1);
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Delete
  // ---------------------------------------------------------------------------

  /// Deletes a todo and refreshes the list.
  ///
  /// Returns `true` on success.
  Future<bool> deleteTodo(String token, int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _apiService.deleteTodo(token, id);

      // Remove from the local list immediately.
      _todos.removeWhere((t) => t.id == id);
      _totalItems--;

      // Clear selected if we just deleted it.
      if (_selectedTodo?.id == id) {
        _selectedTodo = null;
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Utility
  // ---------------------------------------------------------------------------

  /// Clears all state (called on logout).
  void clear() {
    _todos = [];
    _currentPage = 1;
    _totalItems = 0;
    _hasMore = true;
    _isLoading = false;
    _isLoadingDetail = false;
    _selectedTodo = null;
    _errorMessage = null;
    notifyListeners();
  }

  /// Clears the error message.
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
