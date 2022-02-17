import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/base/view/base_view.dart';
import 'view/home/home_view.dart';
import 'view/home/home_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel(),
      ),
    ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: BaseView(
        onPageBuilder: (context, value) => const Scaffold(body: HomeView()),
      ),
    );
  }
}
