import 'package:ass_downloader_example/app/routes.dart';
import 'package:flutter/cupertino.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => CupertinoApp(
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
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child!,
        ),
      );
}
