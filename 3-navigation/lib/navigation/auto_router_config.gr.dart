// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'auto_router_config.dart';

/// generated route for
/// [ArticleDetailScreen]
class ArticleDetailRoute extends PageRouteInfo<ArticleDetailRouteArgs> {
  ArticleDetailRoute({
    Key? key,
    required String articleId,
    Article? article,
    List<PageRouteInfo>? children,
  }) : super(
         ArticleDetailRoute.name,
         args: ArticleDetailRouteArgs(
           key: key,
           articleId: articleId,
           article: article,
         ),
         rawPathParams: {'articleId': articleId},
         initialChildren: children,
       );

  static const String name = 'ArticleDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ArticleDetailRouteArgs>(
        orElse: () => ArticleDetailRouteArgs(
          articleId: pathParams.getString('articleId'),
        ),
      );
      return ArticleDetailScreen(
        key: args.key,
        articleId: args.articleId,
        article: args.article,
      );
    },
  );
}

class ArticleDetailRouteArgs {
  const ArticleDetailRouteArgs({
    this.key,
    required this.articleId,
    this.article,
  });

  final Key? key;

  final String articleId;

  final Article? article;

  @override
  String toString() {
    return 'ArticleDetailRouteArgs{key: $key, articleId: $articleId, article: $article}';
  }
}

/// generated route for
/// [ArticleListScreen]
class ArticleListRoute extends PageRouteInfo<ArticleListRouteArgs> {
  ArticleListRoute({
    Key? key,
    required String categoryName,
    void Function(Article)? onArticleTap,
    List<PageRouteInfo>? children,
  }) : super(
         ArticleListRoute.name,
         args: ArticleListRouteArgs(
           key: key,
           categoryName: categoryName,
           onArticleTap: onArticleTap,
         ),
         rawPathParams: {'categoryName': categoryName},
         initialChildren: children,
       );

  static const String name = 'ArticleListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ArticleListRouteArgs>(
        orElse: () => ArticleListRouteArgs(
          categoryName: pathParams.getString('categoryName'),
        ),
      );
      return ArticleListScreen(
        key: args.key,
        categoryName: args.categoryName,
        onArticleTap: args.onArticleTap,
      );
    },
  );
}

class ArticleListRouteArgs {
  const ArticleListRouteArgs({
    this.key,
    required this.categoryName,
    this.onArticleTap,
  });

  final Key? key;

  final String categoryName;

  final void Function(Article)? onArticleTap;

  @override
  String toString() {
    return 'ArticleListRouteArgs{key: $key, categoryName: $categoryName, onArticleTap: $onArticleTap}';
  }
}

/// generated route for
/// [CategoryListScreen]
class CategoryListRoute extends PageRouteInfo<CategoryListRouteArgs> {
  CategoryListRoute({
    Key? key,
    void Function(NewsCategory)? onCategoryTap,
    List<PageRouteInfo>? children,
  }) : super(
         CategoryListRoute.name,
         args: CategoryListRouteArgs(key: key, onCategoryTap: onCategoryTap),
         initialChildren: children,
       );

  static const String name = 'CategoryListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryListRouteArgs>(
        orElse: () => const CategoryListRouteArgs(),
      );
      return CategoryListScreen(
        key: args.key,
        onCategoryTap: args.onCategoryTap,
      );
    },
  );
}

class CategoryListRouteArgs {
  const CategoryListRouteArgs({this.key, this.onCategoryTap});

  final Key? key;

  final void Function(NewsCategory)? onCategoryTap;

  @override
  String toString() {
    return 'CategoryListRouteArgs{key: $key, onCategoryTap: $onCategoryTap}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    VoidCallback? onLoginSuccess,
    List<PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, onLoginSuccess: onLoginSuccess),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return LoginScreen(key: args.key, onLoginSuccess: args.onLoginSuccess);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLoginSuccess});

  final Key? key;

  final VoidCallback? onLoginSuccess;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginSuccess: $onLoginSuccess}';
  }
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [SearchScreen]
class SearchRoute extends PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    Key? key,
    String? initialQuery,
    void Function(Article)? onArticleTap,
    List<PageRouteInfo>? children,
  }) : super(
         SearchRoute.name,
         args: SearchRouteArgs(
           key: key,
           initialQuery: initialQuery,
           onArticleTap: onArticleTap,
         ),
         rawQueryParams: {'initialQuery': initialQuery},
         initialChildren: children,
       );

  static const String name = 'SearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<SearchRouteArgs>(
        orElse: () => SearchRouteArgs(
          initialQuery: queryParams.optString('initialQuery'),
        ),
      );
      return SearchScreen(
        key: args.key,
        initialQuery: args.initialQuery,
        onArticleTap: args.onArticleTap,
      );
    },
  );
}

class SearchRouteArgs {
  const SearchRouteArgs({this.key, this.initialQuery, this.onArticleTap});

  final Key? key;

  final String? initialQuery;

  final void Function(Article)? onArticleTap;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, initialQuery: $initialQuery, onArticleTap: $onArticleTap}';
  }
}
