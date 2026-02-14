// =============================================================================
// Home Screen
// =============================================================================
// Concepts demonstrated:
// - TabController + TabBar + TabBarView — tabbed navigation
// - SingleTickerProviderStateMixin — provides Ticker for TabController
// - Scaffold with drawer, appBar, body, floatingActionButton
// - FloatingActionButton — adaptive (shown on Android/web, AppBar on iOS)
// - Platform-adaptive UI using Theme.platform
// - Drawer integration — opening via Scaffold.of or AppBar leading
// - Tab change listener — reacting to tab switches
// - Data passing between screens via shared providers
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/route_names.dart';
import '../../providers/auth_provider.dart';
import '../../providers/todo_provider.dart';
import '../../widgets/app_drawer.dart';

import 'tabs/todo_list_tab.dart';
import 'tabs/todo_grid_tab.dart';
import 'tabs/widgets_demo_tab.dart';
import 'tabs/settings_tab.dart';

/// The main screen with a TabBar, Drawer, and adaptive FAB.
///
/// Uses [TabController] to manage four tabs:
/// 1. Todo List (ListView)
/// 2. Todo Grid (GridView)
/// 3. Widgets Demo
/// 4. Settings
///
/// The FAB is shown on Android/web for adding new todos.
/// On iOS, an AppBar action button is used instead (following platform conventions).
class HomeScreen extends StatefulWidget {
  /// Creates the home screen.
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // ---------------------------------------------------------------------------
  // Tab controller
  // ---------------------------------------------------------------------------

  /// Controls which tab is visible and animates between them.
  ///
  /// [SingleTickerProviderStateMixin] provides the `vsync` parameter,
  /// which ties the controller's animations to the screen refresh rate.
  late final TabController _tabController;

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    // Create the tab controller with the number of tabs.
    _tabController = TabController(
      length: 4, // Number of tabs
      vsync: this, // Ticker provider (this State, via the mixin)
      // initialIndex: 0,  // Starting tab (default is 0)
    );

    // Listen for tab changes (e.g., to load data for the new tab).
    _tabController.addListener(_onTabChanged);

    // Load initial data after the widget is built.
    // addPostFrameCallback runs after the current frame is painted,
    // ensuring the context is fully available.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Tab change handler
  // ---------------------------------------------------------------------------

  /// Called whenever the active tab changes.
  ///
  /// [TabController.indexIsChanging] is true during the swipe/tap animation.
  /// We check for it to avoid running logic twice (once during animation,
  /// once after).
  void _onTabChanged() {
    if (_tabController.indexIsChanging) return; // Skip animation phase
    // You could load tab-specific data here.
    // For example, refresh todos when switching to the list tab.
  }

  // ---------------------------------------------------------------------------
  // Data loading
  // ---------------------------------------------------------------------------

  /// Loads the initial todo list.
  void _loadInitialData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    if (authProvider.token != null) {
      todoProvider.fetchTodos(authProvider.token!);
    }
  }

  // ---------------------------------------------------------------------------
  // Navigation
  // ---------------------------------------------------------------------------

  /// Navigates to the todo form screen for creating a new todo.
  void _navigateToAddTodo() {
    Navigator.pushNamed(context, RouteNames.todoForm);
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // Check if the platform is iOS for adaptive FAB behavior.
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      // -----------------------------------------------------------------------
      // AppBar with TabBar
      // -----------------------------------------------------------------------
      appBar: AppBar(
        title: const Text('Flutter Basics'),
        // On iOS, show an add button in the AppBar instead of a FAB.
        actions: [
          if (isIOS)
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add Todo',
              onPressed: _navigateToAddTodo,
            ),
        ],
        // TabBar is placed in the AppBar's bottom slot.
        bottom: TabBar(
          controller: _tabController,
          // isScrollable: false,     // true = tabs scroll horizontally
          // padding: EdgeInsets.zero, // Padding around the tab bar
          // labelPadding: ...,       // Padding around each tab label
          // indicatorWeight: 2.0,    // Indicator line thickness
          // indicatorPadding: ...,   // Padding around indicator
          // indicator: ...,          // Custom indicator decoration
          tabs: const [
            Tab(icon: Icon(Icons.list), text: 'List'),
            Tab(icon: Icon(Icons.grid_view), text: 'Grid'),
            Tab(icon: Icon(Icons.widgets), text: 'Widgets'),
            Tab(icon: Icon(Icons.settings), text: 'Settings'),
          ],
        ),
      ),

      // -----------------------------------------------------------------------
      // Drawer
      // -----------------------------------------------------------------------
      drawer: const AppDrawer(),

      // -----------------------------------------------------------------------
      // Body — TabBarView
      // -----------------------------------------------------------------------
      // TabBarView displays the content for the selected tab.
      // It must have the same number of children as TabBar has tabs.
      body: TabBarView(
        controller: _tabController,
        // physics: NeverScrollableScrollPhysics(), // Disable swipe between tabs
        children: [
          // Tab 1: Todo List
          const TodoListTab(),
          // Tab 2: Todo Grid
          const TodoGridTab(),
          // Tab 3: Widgets Demo
          const WidgetsDemoTab(),
          // Tab 4: Settings
          const SettingsTab(),
        ],
      ),

      // -----------------------------------------------------------------------
      // FloatingActionButton (Android/web only)
      // -----------------------------------------------------------------------
      // On iOS, the add button is in the AppBar instead.
      // This demonstrates platform-adaptive UI.
      floatingActionButton: isIOS
          ? null // No FAB on iOS
          : FloatingActionButton(
              onPressed: _navigateToAddTodo,
              tooltip: 'Add Todo',
              // heroTag: 'add_todo_fab',  // Unique tag if multiple FABs exist
              // mini: false,              // Smaller FAB variant
              // shape: ...,              // Custom shape (from theme)
              // elevation: ...,          // Shadow depth (from theme)
              // backgroundColor: ...,    // Background (from theme)
              // foregroundColor: ...,    // Icon color (from theme)
              child: const Icon(Icons.add),
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // ↑ Controls where the FAB is positioned.
      // Options: endFloat (default), centerFloat, endDocked, centerDocked, etc.
    );
  }

}
