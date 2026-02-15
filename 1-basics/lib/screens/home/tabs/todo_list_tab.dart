// =============================================================================
// Todo List Tab
// =============================================================================
// Concepts demonstrated:
// - ListView.builder — efficiently builds list items on demand
// - ListView.separated — adds separators between items
// - ScrollController — detecting scroll position for infinite scroll
// - RefreshIndicator — pull-to-refresh gesture
// - Consumer — rebuilding when provider state changes
// - Dismissible — swipe-to-delete and swipe-to-complete gestures
// - Divider — horizontal line between list items
// - Empty state, loading state, error state handling
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/route_names.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/todo_provider.dart';
import '../../../widgets/todo_list_item.dart';

/// Displays todos in a scrollable list with pull-to-refresh and infinite scroll.
///
/// Uses [ListView.builder] which only builds widgets that are visible
/// on screen. This is critical for performance with large lists — a
/// regular Column would build ALL items at once.
class TodoListTab extends StatefulWidget {
  /// Creates the todo list tab.
  const TodoListTab({super.key});

  @override
  State<TodoListTab> createState() => _TodoListTabState();
}

class _TodoListTabState extends State<TodoListTab> {
  // ---------------------------------------------------------------------------
  // Scroll controller
  // ---------------------------------------------------------------------------

  /// Tracks scroll position to implement infinite scroll (pagination).
  ///
  /// When the user scrolls near the bottom, we load the next page.
  /// Must be disposed in dispose().
  final _scrollController = ScrollController();

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    // Add a listener that fires on every scroll event.
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Infinite scroll
  // ---------------------------------------------------------------------------

  /// Called on every scroll event.
  ///
  /// Checks if the user has scrolled within 200 pixels of the bottom.
  /// If so, loads the next page of todos.
  void _onScroll() {
    // maxScrollExtent is the furthest the user can scroll.
    // offset is the current scroll position.
    // When offset >= maxScrollExtent - 200, we're near the bottom.
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadNextPage();
    }
  }

  /// Loads the next page of todos if available.
  void _loadNextPage() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    if (authProvider.token != null) {
      todoProvider.loadNextPage(authProvider.token!);
    }
  }

  /// Refreshes the todo list (pull-to-refresh).
  Future<void> _onRefresh() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    if (authProvider.token != null) {
      await todoProvider.refreshTodos(authProvider.token!);
    }
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        // -- Error state --
        if (todoProvider.errorMessage != null && todoProvider.todos.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  todoProvider.errorMessage!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onRefresh,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // -- Empty state --
        if (todoProvider.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inbox,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  'No todos yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap + to create your first todo',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          );
        }

        // -- List with data --
        // RefreshIndicator wraps a scrollable widget and adds
        // the pull-to-refresh gesture.
        return RefreshIndicator(
          onRefresh: _onRefresh,
          // color: ...,                  // Spinner color
          // backgroundColor: ...,        // Spinner background
          // displacement: 40,            // How far to pull before triggering
          // edgeOffset: 0,               // Offset from top
          // strokeWidth: 2.5,            // Spinner thickness

          // ListView.separated is like ListView.builder but adds a separator
          // widget between each item. This is cleaner than adding Dividers
          // manually inside the item builder.
          child: ListView.separated(
            controller: _scrollController,
            // physics: AlwaysScrollableScrollPhysics(),
            // ↑ Allows pull-to-refresh even when the list is short.
            // Without it, RefreshIndicator won't work if content doesn't scroll.
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),

            // itemCount includes an extra item for the loading indicator.
            itemCount: todoProvider.todos.length +
                (todoProvider.hasMore ? 1 : 0),

            // separatorBuilder creates the widget between items.
            separatorBuilder: (context, index) {
              return const Divider(
                // height: 1,              // Total space (including line)
                // thickness: 1,           // Line thickness (from theme)
                // indent: 72,             // Left inset (after leading widget)
                // endIndent: 16,          // Right inset
                // color: ...,             // Line color (from theme)
                height: 1,
              );
            },

            // itemBuilder creates each list item.
            // Called lazily — only for items currently visible.
            itemBuilder: (context, index) {
              // Show loading indicator at the bottom.
              if (index >= todoProvider.todos.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final todo = todoProvider.todos[index];
              final token = Provider.of<AuthProvider>(
                context,
                listen: false,
              ).token;

              // Dismissible adds swipe gestures to its child.
              // - Swipe left (endToStart) → delete
              // - Swipe right (startToEnd) → mark as checked
              //
              // Each Dismissible needs a unique Key so Flutter can
              // track which item was dismissed in the list.
              return Dismissible(
                key: ValueKey(todo.id),

                // -- Swipe right: mark as checked --
                // background is shown when swiping startToEnd (left→right).
                background: Container(
                  color: Colors.green,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 24),
                  child: const Icon(Icons.check, color: Colors.white),
                ),

                // -- Swipe left: delete --
                // secondaryBackground is shown when swiping endToStart (right→left).
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 24),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                // confirmDismiss lets you control what happens on each direction.
                // Return true to remove the item, false to snap it back.
                confirmDismiss: (direction) async {
                  if (token == null) return false;

                  if (direction == DismissDirection.startToEnd) {
                    // Swipe right → toggle checked to true.
                    // Don't dismiss (remove from list) — just mark checked.
                    if (!todo.checked) {
                      todoProvider.toggleChecked(token, todo.id, todo.checked);
                    }
                    return false; // Snap back, don't remove
                  } else {
                    // Swipe left → delete.
                    final success =
                        await todoProvider.deleteTodo(token, todo.id);
                    return success; // Remove from list if deletion succeeded
                  }
                },

                child: TodoListItem(
                  todo: todo,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.todoDetail,
                      arguments: todo.id,
                    );
                  },
                  onToggle: (_) {
                    if (token != null) {
                      todoProvider.toggleChecked(token, todo.id, todo.checked);
                    }
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
