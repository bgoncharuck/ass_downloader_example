import 'package:ass_downloader_example/app/routes.dart';
import 'package:flutter/cupertino.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => CupertinoApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoute,
        initialRoute: pathMenu,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child!,
        ),
      );
}
