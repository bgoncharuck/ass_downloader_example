import 'package:ass_downloader_example/models/download_group.dart';
import 'package:ass_downloader_example/screens/Image_asset_group_view/image_asset_group_view_screen.dart';
import 'package:ass_downloader_example/screens/Image_asset_group_view/image_asset_group_view_screen_controller.dart';
import 'package:ass_downloader_example/screens/download_group/download_group_screen.dart';
import 'package:ass_downloader_example/screens/download_group/download_group_screen_controller.dart';
import 'package:ass_downloader_example/screens/error/error_screen.dart';
import 'package:ass_downloader_example/screens/error/error_screen_controller.dart';
import 'package:ass_downloader_example/screens/loading/loading_screen.dart';
import 'package:ass_downloader_example/screens/loading/loading_screen_controller.dart';
import 'package:ass_downloader_example/screens/menu/menu_screen.dart';
import 'package:ass_downloader_example/screens/menu/menu_screen_controller.dart';
import 'package:flutter/widgets.dart';

late final GlobalKey<NavigatorState> navigatorKey;

// Define constants for route paths
const String pathMenu = '/menu';
const String pathGroups = '/groups';
const String pathGroup = '/group';
const String pathError = '/error';
const String pathLoading = '/loading';

// Function to generate routes based on RouteSettings
Route<dynamic> generateRoute(RouteSettings settings) {
  // Extract arguments from settings
  final arguments = settings.arguments;

  // Define a variable to hold the constructed widget tree for the route
  Widget path;

  // Switch statement to handle different routes based on the name
  switch (settings.name) {
    // Handle route with no arguments
    case pathLoading:
    case '/':
      path = LoadingScreenLocator(
        controller: LoadingScreenController(),
        child: const LoadingScreen(),
      );
    // Handle route with a single argument (asset group path)
    case pathMenu:
      path = MenuScreenLocator(
        controller: MenuScreenController(
          arguments! as Map<String, DownloadGroup>,
        ),
        child: const MenuScreen(),
      );
    case pathGroups:
      path = DownloadGroupScreenLocator(
        controller: DownloadGroupScreenController(
          downloadGroup: arguments! as DownloadGroup, // Cast arguments
        ),
        child: const DownloadGroupScreen(),
      );
    case pathGroup:
      // Handle route with multiple arguments
      path = ImageAssetGroupViewScreenLocator(
        controller: ImageAssetGroupViewScreenController(
          fromDownloadGroup: (arguments! as List)[0] as DownloadGroup,
          assetGroupName: (arguments as List)[1] as String,
          // ... other arguments parsing logic (if applicable)
        ),
        child: const ImageAssetGroupViewScreen(),
      );
    case pathError:
      path = ErrorScreenLocator(
        controller: ErrorScreenController(
          errorMessage: (arguments! as List)[0] as String,
          action: (arguments as List)[1] as void Function(),
        ),
        child: const ErrorScreen(),
      );

    default:
      throw const RouteException('Route not found');
  }

  // Wrap the constructed route tree with a TransitionBuilder
  // for a beautiful animation
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
