import 'view/skeleton/skeleton_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constant/routes.dart';
import 'view/details/details_viewmodel.dart';
import 'view/home/home_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => SkeletonViewModel(),
      ),
        ChangeNotifierProvider(create: (context) => HomeViewModel(),
      ),
        ChangeNotifierProvider(create: (context) => DetailsViewModel(),
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
      routes: Routes.getRoutes(context),
      initialRoute: Routes.skeleton
    );
  }
}
