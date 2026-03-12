import 'package:auto_route/auto_route.dart';

import '../../features/call_room/presentation/pages/call_room_page.dart';
import '../../features/settings/presentation/pages/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/', initial: true),
    AutoRoute(page: CallRoomRoute.page, path: '/call'),
  ];
}
