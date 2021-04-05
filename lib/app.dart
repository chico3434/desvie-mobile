import 'package:desvie/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:desvie/screens/home_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeManager>(
      create: (_) => ThemeManager(),
      child: Consumer<ThemeManager>(builder: (context, manager, _) {
        return MaterialApp(
          theme: manager.themeData,
          home: HomeScreen(),
        );
      }),
    );
  }
}
