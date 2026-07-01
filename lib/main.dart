import 'package:flutter/material.dart';
import 'package:my_provider/product_list_app/screens/product_list_screen.dart';
import 'package:my_provider/provider/counterProvider.dart';
import 'package:my_provider/provider/product_list_provider.dart';
import 'package:my_provider/provider/theme_provider.dart';
import 'package:my_provider/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => ProductListProvider()),
      ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  brightness: Brightness.light,
                  colorSchemeSeed: Colors.green
                ),
                darkTheme: ThemeData(
                    brightness: Brightness.dark
                ),
                home: ProductListScreen(),
                themeMode: themeProvider.themeMode,

              );
            }
          ),
        );
  }
}

