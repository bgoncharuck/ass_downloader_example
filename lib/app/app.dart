import 'package:ass_downloader_example/app/routes.dart';
import 'package:flutter/cupertino.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    navigatorKey = GlobalKey<NavigatorState>();

    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      initialRoute: pathLoading,
      navigatorKey: navigatorKey,
      theme: const CupertinoThemeData.raw(
        Brightness.dark,
        CupertinoColors.activeBlue,
        CupertinoColors.systemGreen,
        CupertinoTextThemeData(),
        CupertinoColors.darkBackgroundGray,
        CupertinoColors.darkBackgroundGray,
        true,
      ),
    );
  }
}
