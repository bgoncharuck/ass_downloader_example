import 'package:ass_downloader_example/config/app/init.dart';
import 'package:ass_downloader_example/config/widgets_binding/widgets_binding.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  await const InitializeApp().execute(
    params: () => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    widgetsBinding.removeSplashScreen();
  }

  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('test', textDirection: TextDirection.ltr));
}
