import 'package:ass_downloader_example/screens/asset_group_view/asset_group_view_screen.dart';
import 'package:ass_downloader_example/screens/asset_group_view/asset_group_view_screen_controller.dart';
import 'package:ass_downloader_example/screens/asset_groups/asset_groups_screen.dart';
import 'package:ass_downloader_example/screens/asset_groups/asset_groups_screen_controller.dart';
import 'package:ass_downloader_example/screens/menu/menu_screen.dart';
import 'package:ass_downloader_example/screens/menu/menu_screen_controller.dart';
import 'package:flutter/widgets.dart';

const String pathMenu = '/menu';
const String pathGroups = '/groups';
const String pathGroup = '/group';

Route<dynamic> generateRoute(RouteSettings settings) {
  final arguments = settings.arguments;

  Widget path;
  switch (settings.name) {
    case pathMenu:
    case '/':
      path = MenuScreenLocator(
        controller: MenuScreenController(),
        child: const MenuScreen(),
      );
    case pathGroups:
      path = AssetGroupsScreenLocator(
        controller: AssetGroupsScreenController(
          assetGroupNames: arguments! as List<String>,
        ),
        child: const AssetGroupsScreen(),
      );
    case pathGroup:
      path = AssetGroupViewScreenLocator(
        controller: AssetGroupViewScreenController(
          fromAssetGroups: (arguments! as List)[0] as List<String>,
          assetGroupName: (arguments as List)[1] as String,
        ),
        child: const AssetGroupViewScreen(),
      );
    default:
      throw const RouteException('Route not found');
  }

  return TransitionBuilder(
    route: path,
  );
}

class RouteException implements Exception {
  const RouteException(this.message);
  final String message;
}

// ignore: strict_raw_type
class TransitionBuilder extends PageRouteBuilder {
  TransitionBuilder({
    required this.route,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  }) : super(
          pageBuilder: (context, animate, _) => route,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, anim, child) {
            final animated = Tween<double>(
              begin: 0,
              end: 1,
            ).chain(CurveTween(curve: curve)).animate(animation);
            return FadeTransition(opacity: animated, child: child);
          },
        );

  final Widget route;
  final Duration duration;
  final Duration reverseDuration;
  final Curve curve;
}
