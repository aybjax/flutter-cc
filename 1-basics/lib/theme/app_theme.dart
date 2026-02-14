// =============================================================================
// App Theme
// =============================================================================
// Concepts demonstrated:
// - ThemeData — the master object that controls look and feel of Material widgets
// - ColorScheme — the unified color system in Material 3
// - Component themes (AppBarTheme, CardTheme, etc.) — fine-grained styling
// - Light vs dark theme variations
// - const constructors for performance (compile-time constants)
// - Commented-out fields show all available options for learning
// =============================================================================

import 'package:flutter/material.dart';

/// Provides [ThemeData] for light and dark modes.
///
/// Material 3 (useMaterial3: true) is the modern design system.
/// The [ColorScheme] drives the colors of most widgets automatically,
/// but component themes let you override specific widgets.
abstract final class AppTheme {
  // ---------------------------------------------------------------------------
  // Shared constants
  // ---------------------------------------------------------------------------

  /// The border radius used across cards, buttons, inputs, etc.
  static const double _borderRadius = 12.0;

  /// Standard content padding.
  static const double _padding = 16.0;

  // ---------------------------------------------------------------------------
  // Light Theme
  // ---------------------------------------------------------------------------

  /// The complete light theme for the app.
  ///
  /// [ThemeData] has dozens of fields. The most important ones are specified
  /// below; many others are commented out with explanations.
  static ThemeData get lightTheme {
    // ColorScheme.fromSeed generates a full palette from a single seed color.
    // Material 3 uses this palette to color surfaces, text, icons, etc.
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.light,
      // surface: Colors.white,          // Background of cards, dialogs
      // onSurface: Colors.black87,      // Text/icons on surface
      // primary: Colors.indigo,         // Buttons, FAB, AppBar (M3)
      // onPrimary: Colors.white,        // Text/icons on primary color
      // secondary: Colors.teal,         // Secondary actions
      // onSecondary: Colors.white,      // Text/icons on secondary
      // error: Colors.red,             // Error states (form validation)
      // onError: Colors.white,         // Text/icons on error color
      // surfaceContainerHighest: ...,  // M3 surface tonal elevation
    );

    return ThemeData(
      // -- Core --
      useMaterial3: true, // Enable Material 3 design system
      colorScheme: colorScheme, // The unified color palette

      // brightness: Brightness.light,        // Inferred from colorScheme
      // primaryColor: Colors.indigo,         // Legacy — prefer colorScheme
      // scaffoldBackgroundColor: ...,        // Defaults to colorScheme.surface
      // canvasColor: ...,                    // Background of Drawer, DropdownMenu
      // cardColor: ...,                      // Legacy — use cardTheme instead
      // dividerColor: ...,                   // Legacy — use dividerTheme
      // focusColor: ...,                     // Overlay when widget is focused
      // hoverColor: ...,                     // Overlay on hover (desktop/web)
      // highlightColor: ...,                 // Ink highlight on press
      // splashColor: ...,                    // Ink splash ripple color
      // splashFactory: ...,                  // InkSplash, InkRipple, NoSplash
      // visualDensity: VisualDensity.adaptivePlatformDensity,

      // -- AppBar --
      appBarTheme: AppBarTheme(
        centerTitle: true, // Center the title text
        elevation: 0, // Flat app bar (Material 3 style)
        scrolledUnderElevation: 1, // Slight elevation when content scrolls under
        backgroundColor: colorScheme.surface, // Match the surface color
        foregroundColor: colorScheme.onSurface, // Title and icon color
        // surfaceTintColor: Colors.transparent,   // Remove M3 tint
        // shadowColor: Colors.black26,            // Shadow when elevated
        // toolbarHeight: kToolbarHeight,          // Default is 56.0
        // titleSpacing: NavigationToolbar.kMiddleSpacing, // Spacing around title
        // iconTheme: IconThemeData(...),          // Leading/trailing icon style
        // actionsIconTheme: IconThemeData(...),   // Action icons specifically
        // titleTextStyle: TextStyle(...),         // Custom title text style
        // systemOverlayStyle: ...,               // Status bar style (light/dark)
      ),

      // -- Card --
      cardTheme: CardThemeData(
        elevation: 1, // Subtle shadow
        shadowColor: Colors.black26, // Shadow color
        // surfaceTintColor: Colors.transparent,   // Remove M3 surface tint
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: _padding,
          vertical: _padding / 2,
        ),
        clipBehavior: Clip.antiAlias, // Clip children to card shape
        // color: colorScheme.surface,             // Card background
      ),

      // -- ElevatedButton --
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary, // Text color
          backgroundColor: colorScheme.primary, // Button background
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          elevation: 2, // Shadow depth
          // shadowColor: Colors.black38,           // Shadow color
          // minimumSize: Size(88, 36),             // Minimum tap target
          // maximumSize: Size.infinite,            // Maximum size
          // side: BorderSide(...),                 // Border around button
          // textStyle: TextStyle(...),             // Override text style
          // tapTargetSize: MaterialTapTargetSize.padded,  // Touch area
          // animationDuration: Duration(milliseconds: 200),
          // enableFeedback: true,                  // Haptic/sound feedback
        ),
      ),

      // -- TextButton --
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary, // Text color
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          // backgroundColor: Colors.transparent,  // Usually no background
          // textStyle: TextStyle(...),
        ),
      ),

      // -- OutlinedButton --
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary, // Text color
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          side: BorderSide(
            color: colorScheme.outline, // Border color
            width: 1.5,
          ),
          // backgroundColor: Colors.transparent,
        ),
      ),

      // -- InputDecoration (TextField / TextFormField) --
      inputDecorationTheme: InputDecorationTheme(
        filled: true, // Show a background fill
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: _padding,
          vertical: _padding,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        // labelStyle: TextStyle(...),              // Label text style
        // hintStyle: TextStyle(...),               // Hint text style
        // errorStyle: TextStyle(...),              // Error message style
        // prefixIconColor: ...,                    // Icon before text
        // suffixIconColor: ...,                    // Icon after text
        // floatingLabelBehavior: FloatingLabelBehavior.auto, // Label animation
        // isDense: false,                          // Compact mode
        // isCollapsed: false,                      // Very compact mode
      ),

      // -- TextTheme --
      textTheme: const TextTheme(
        // displayLarge:  TextStyle(fontSize: 57, fontWeight: FontWeight.w400),
        // displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
        // displaySmall:  TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),

      // -- FloatingActionButton --
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        // highlightElevation: 8,                 // Elevation when pressed
        // splashColor: ...,                       // Ripple color
        // extendedPadding: ...,                   // Padding for extended FAB
        // extendedTextStyle: ...,                 // Text style for extended FAB
      ),

      // -- Divider --
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant, // Subtle divider color
        thickness: 1, // Line thickness in logical pixels
        space: 1, // Total space (including line) taken by divider
        // indent: 0,                              // Left inset
        // endIndent: 0,                           // Right inset
      ),

      // -- SnackBar --
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating, // Float above bottom nav
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        // backgroundColor: ...,                   // Defaults to inverseSurface
        // contentTextStyle: ...,                   // Text style
        // actionTextColor: ...,                    // Action button color
        // elevation: 6,                            // Shadow
        // width: ...,                              // Fixed width (floating only)
        // insetPadding: ...,                       // Padding from edges
        // showCloseIcon: false,                    // Show X button
        // closeIconColor: ...,                     // X button color
      ),

      // -- Dialog --
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        elevation: 6,
        // backgroundColor: colorScheme.surface,   // Dialog background
        // titleTextStyle: ...,                     // Title style
        // contentTextStyle: ...,                   // Body text style
        // actionsPadding: ...,                     // Padding around buttons
        // alignment: ...,                          // Dialog position on screen
      ),

      // -- ListTile --
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: _padding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        // tileColor: ...,                         // Background color
        // selectedTileColor: ...,                  // Background when selected
        // iconColor: ...,                         // Leading/trailing icon color
        // textColor: ...,                         // Title text color
        // dense: false,                           // Compact mode
        // visualDensity: ...,                     // Fine-grained density
        // minLeadingWidth: ...,                   // Min width for leading widget
        // minVerticalPadding: ...,                // Vertical padding
        // enableFeedback: true,                   // Haptic/sound feedback
      ),

      // -- TabBar --
      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.primary, // Selected tab text color
        unselectedLabelColor: colorScheme.onSurfaceVariant, // Unselected tab color
        indicatorColor: colorScheme.primary, // Indicator bar color
        indicatorSize: TabBarIndicatorSize.label, // Indicator width matches label
        // dividerColor: ...,                      // Line below tab bar
        // dividerHeight: ...,                     // Line thickness
        // labelStyle: TextStyle(...),             // Selected tab text style
        // unselectedLabelStyle: TextStyle(...),   // Unselected tab text style
        // overlayColor: ...,                      // Splash/hover color
        // splashFactory: ...,                     // Ripple style
        // tabAlignment: TabAlignment.fill,        // How tabs fill the bar
      ),

      // -- Drawer --
      drawerTheme: DrawerThemeData(
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        backgroundColor: colorScheme.surface,
        // surfaceTintColor: ...,                  // M3 surface tint
        // shadowColor: ...,                       // Shadow color
        // width: 304,                             // Drawer width
        // scrimColor: Colors.black54,             // Overlay behind drawer
      ),

      // -- Checkbox --
      // checkboxTheme: CheckboxThemeData(
      //   fillColor: WidgetStateProperty.resolveWith((states) {
      //     if (states.contains(WidgetState.selected)) {
      //       return colorScheme.primary;
      //     }
      //     return Colors.transparent;
      //   }),
      //   checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      //   side: BorderSide(color: colorScheme.outline, width: 2),
      // ),

      // -- Switch --
      // switchTheme: SwitchThemeData(
      //   thumbColor: WidgetStateProperty.resolveWith((states) {
      //     if (states.contains(WidgetState.selected)) {
      //       return colorScheme.onPrimary;
      //     }
      //     return colorScheme.outline;
      //   }),
      //   trackColor: WidgetStateProperty.resolveWith((states) {
      //     if (states.contains(WidgetState.selected)) {
      //       return colorScheme.primary;
      //     }
      //     return colorScheme.surfaceContainerHighest;
      //   }),
      // ),

      // -- BottomNavigationBar (if using instead of TabBar) --
      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: colorScheme.primary,
      //   unselectedItemColor: colorScheme.onSurfaceVariant,
      //   backgroundColor: colorScheme.surface,
      //   elevation: 8,
      // ),

      // -- Tooltip --
      // tooltipTheme: TooltipThemeData(
      //   decoration: BoxDecoration(
      //     color: colorScheme.inverseSurface,
      //     borderRadius: BorderRadius.circular(8),
      //   ),
      //   textStyle: TextStyle(color: colorScheme.onInverseSurface),
      //   waitDuration: Duration(milliseconds: 500),
      // ),

      // -- ProgressIndicator --
      // progressIndicatorTheme: ProgressIndicatorThemeData(
      //   color: colorScheme.primary,
      //   linearTrackColor: colorScheme.surfaceContainerHighest,
      //   circularTrackColor: colorScheme.surfaceContainerHighest,
      // ),
    );
  }

  // ---------------------------------------------------------------------------
  // Dark Theme
  // ---------------------------------------------------------------------------

  /// The complete dark theme for the app.
  ///
  /// Most component themes mirror the light theme; only the [ColorScheme]
  /// changes (brightness: Brightness.dark). Material 3's seed-based system
  /// automatically adjusts colors for dark mode.
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),

      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: _padding,
          vertical: _padding / 2,
        ),
        clipBehavior: Clip.antiAlias,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          elevation: 2,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          side: BorderSide(color: colorScheme.outline, width: 1.5),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: _padding,
          vertical: _padding,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
      ),

      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        elevation: 6,
      ),

      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: _padding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        indicatorColor: colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.label,
      ),

      drawerTheme: DrawerThemeData(
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        backgroundColor: colorScheme.surface,
      ),
    );
  }
}
