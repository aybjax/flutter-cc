// =============================================================================
// Todo Grid Tab
// =============================================================================
// Concepts demonstrated:
// - GridView.builder — efficiently builds grid items on demand
// - SliverGridDelegateWithFixedCrossAxisCount — grid layout configuration
// - ScrollController for infinite scroll in grids
// - RefreshIndicator with GridView
// - Consumer for provider-driven rebuilds
// - Responsive grid: could adjust crossAxisCount based on screen width
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/route_names.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/todo_provider.dart';
import '../../../widgets/todo_grid_item.dart';

/// Displays todos in a grid layout with cards.
///
/// Uses [GridView.builder] which, like [ListView.builder], only builds
/// items that are visible on screen.
class TodoGridTab extends StatefulWidget {
  /// Creates the todo grid tab.
  const TodoGridTab({super.key});

  @override
  State<TodoGridTab> createState() => _TodoGridTabState();
}

class _TodoGridTabState extends State<TodoGridTab> {
  /// Scroll controller for infinite scroll.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// Loads next page when scrolled near the bottom.
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final todoProvider = Provider.of<TodoProvider>(context, listen: false);
      if (authProvider.token != null) {
        todoProvider.loadNextPage(authProvider.token!);
      }
    }
  }

  /// Pull-to-refresh handler.
  Future<void> _onRefresh() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    if (authProvider.token != null) {
      await todoProvider.refreshTodos(authProvider.token!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        // -- Loading state (initial load) --
        if (todoProvider.isLoading && todoProvider.todos.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // -- Empty state --
        if (todoProvider.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.grid_off,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  'No todos yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        }

        // -- Grid with data --
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: GridView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),

            // -- Grid delegate --
            // Controls the layout of the grid: columns, spacing, aspect ratio.
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              // crossAxisCount: number of columns.
              crossAxisCount: 2,
              // childAspectRatio: width / height of each cell.
              // 1.0 = square, 0.75 = taller than wide.
              childAspectRatio: 0.85,
              // crossAxisSpacing: horizontal space between cells.
              crossAxisSpacing: 8,
              // mainAxisSpacing: vertical space between cells.
              mainAxisSpacing: 8,
            ),

            // Alternative grid delegate (commented for reference):
            // SliverGridDelegateWithMaxCrossAxisExtent(
            //   maxCrossAxisExtent: 200,    // Max width per cell
            //   childAspectRatio: 0.85,
            //   crossAxisSpacing: 8,
            //   mainAxisSpacing: 8,
            // )

            itemCount: todoProvider.todos.length,

            itemBuilder: (context, index) {
              final todo = todoProvider.todos[index];
              return TodoGridItem(
                todo: todo,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.todoDetail,
                    arguments: todo.id,
                  );
                },
                onToggle: (value) {
                  final token = Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  ).token;
                  if (token != null) {
                    todoProvider.toggleChecked(token, todo.id, todo.checked);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
