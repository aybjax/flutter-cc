// =============================================================================
// TodoListResponse Model (Pagination Wrapper)
// =============================================================================
// Concepts demonstrated:
// - Wrapping a paginated API response in a typed Dart class
// - List.map() and .toList() for transforming JSON arrays
// - Computed getters for pagination logic
// - Generic collection types (List<TodoSummary>)
// =============================================================================

import 'todo_summary.dart';

/// Wraps the paginated response from GET /todos.
///
/// Backend JSON:
/// ```json
/// {
///   "todos": [ { ... }, { ... } ],
///   "total": 42,
///   "page": 1,
///   "page_size": 10
/// }
/// ```
///
/// This class makes pagination calculations (hasMore, totalPages) easy
/// for the UI layer.
class TodoListResponse {
  /// The list of todo summaries for the current page.
  final List<TodoSummary> todos;

  /// Total number of todos across *all* pages.
  final int total;

  /// The current page number (1-based).
  final int page;

  /// Number of items per page.
  final int pageSize;

  /// Creates a [TodoListResponse].
  const TodoListResponse({
    required this.todos,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  /// Deserializes the full paginated response from JSON.
  ///
  /// The `todos` array is transformed using [List.map]:
  /// 1. `json['todos']` returns a `dynamic` (actually `List<dynamic>`)
  /// 2. We cast it to `List<dynamic>`
  /// 3. `.map(...)` applies [TodoSummary.fromJson] to each element
  /// 4. `.toList()` collects the lazy Iterable into a concrete List
  factory TodoListResponse.fromJson(Map<String, dynamic> json) {
    return TodoListResponse(
      todos: (json['todos'] as List<dynamic>)
          .map((item) => TodoSummary.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      pageSize: json['page_size'] as int,
    );
  }

  /// The total number of pages available.
  ///
  /// Uses integer ceiling division: (total + pageSize - 1) ~/ pageSize
  /// The `~/` operator is Dart's *integer division* (truncating division).
  int get totalPages => (total + pageSize - 1) ~/ pageSize;

  /// Whether there are more pages after the current one.
  bool get hasMore => page < totalPages;

  /// Whether the current page is the first page.
  bool get isFirstPage => page <= 1;

  @override
  String toString() =>
      'TodoListResponse(page: $page/$totalPages, '
      'items: ${todos.length}, total: $total)';
}
