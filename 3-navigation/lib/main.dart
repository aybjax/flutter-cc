// =============================================================================
// Main Entry Point — News Reader Navigation Tutorial
// =============================================================================
// Concepts demonstrated:
// - MaterialApp with localization support (l10n)
// - Three navigation approaches compared side by side:
//   1. Default Navigator (imperative push/pop)
//   2. GoRouter (declarative URL-based routing)
//   3. auto_route (code-generated type-safe routing)
// - Deep linking concepts and configuration
// - colorSchemeSeed for Material 3 theming
// - flutter_localizations for multi-language support
//
// App architecture:
// The app uses a TabBar to switch between three navigation approaches.
// Each tab is a self-contained mini-app demonstrating a different routing
// library. All tabs share the same screens, models, and mock data —
// only the navigation logic differs.
//
// Deep linking (concept explanation):
// ------------------------------------
// Deep links allow external URLs to navigate directly to specific screens.
// Setup requires:
// 1. iOS: Add Associated Domains in Xcode + apple-app-site-association file
// 2. Android: Add intent-filter in AndroidManifest.xml
// 3. Use app_links package to handle incoming URLs at runtime
//
// Example deep link flow:
//   User taps: news-reader://article/tech-1
//   → OS launches app (or brings it to foreground)
//   → app_links delivers the URL to your app
//   → Router matches the URL to a route
//   → ArticleDetailScreen displays article "tech-1"
//
// This tutorial focuses on the ROUTER side of deep linking.
// The OS configuration (AndroidManifest, Info.plist) is not covered here.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/generated/app_localizations.dart';
import 'screens/home_screen.dart';

/// The app's entry point.
///
/// Creates a [MaterialApp] with localization support and the [HomeScreen]
/// as the root widget.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NewsReaderApp());
}

// -----------------------------------------------------------------------------
// Root App Widget
// -----------------------------------------------------------------------------

/// The root widget of the News Reader app.
///
/// Configures:
/// - Material 3 theming with [colorSchemeSeed]
/// - Localization delegates for English and Spanish
/// - The [HomeScreen] with tabs for each navigation approach
class NewsReaderApp extends StatelessWidget {
  /// Creates the root app widget.
  const NewsReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // -- App identity --
      title: 'News Reader',

      // debugShowCheckedModeBanner: false,  // Hides the DEBUG banner
      // showPerformanceOverlay: false,      // Shows FPS/GPU graphs

      // -- Theme --
      // Using colorSchemeSeed instead of ColorScheme.fromSeed.
      // This generates a full Material 3 color scheme from a single seed color.
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),

      // -- Localization --
      // These delegates provide translations for Material widgets (e.g.,
      // "OK"/"Cancel" on dialogs) and our custom app strings.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],

      // -- Navigation --
      // The HomeScreen contains a TabBar for switching between
      // the three navigation approaches.
      home: const HomeScreen(),
    );
  }
}

// =============================================================================
// Deep Linking Configuration (reference)
// =============================================================================
//
// To enable deep linking in a production app, you would:
//
// 1. Add the app_links package:
//    dependencies:
//      app_links: ^6.0.0
//
// 2. Configure iOS (ios/Runner/Runner.entitlements):
//    <key>com.apple.developer.associated-domains</key>
//    <array>
//      <string>applinks:your-domain.com</string>
//    </array>
//
// 3. Configure Android (android/app/src/main/AndroidManifest.xml):
//    <intent-filter android:autoVerify="true">
//      <action android:name="android.intent.action.VIEW" />
//      <category android:name="android.intent.category.DEFAULT" />
//      <category android:name="android.intent.category.BROWSABLE" />
//      <data android:scheme="https" android:host="your-domain.com" />
//    </intent-filter>
//
// 4. Handle incoming links in your app:
//    final appLinks = AppLinks();
//
//    // Handle initial link (app was closed)
//    final initialLink = await appLinks.getInitialLink();
//    if (initialLink != null) _handleDeepLink(initialLink);
//
//    // Handle links while app is running
//    appLinks.uriLinkStream.listen(_handleDeepLink);
//
//    void _handleDeepLink(Uri uri) {
//      // GoRouter: goRouter.go(uri.path);
//      // auto_route: autoRouter.navigateNamed(uri.path);
//      // Navigator: parse uri.path and push appropriate route
//    }
//
// 5. Host an apple-app-site-association file on your domain:
//    https://your-domain.com/.well-known/apple-app-site-association
//
// Both GoRouter and auto_route handle the routing side automatically
// once the OS delivers the URL to your app. The key difference is
// how they parse URLs into routes (GoRouter uses path matching,
// auto_route uses code-generated matchers).
