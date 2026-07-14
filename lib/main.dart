import 'package:flutter/material.dart';
import 'package:my_provider/provider/favourite_provider.dart';
import 'package:my_provider/provider/product_list_provider.dart';
import 'package:my_provider/provider/theme_provider.dart';
import 'package:my_provider/screens/login_screen.dart';
import 'package:my_provider/screens/product_list_screen.dart';
import 'package:my_provider/ui/controllers/auth_controllers.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   bool isLoggedIn = await AuthControllers.isUserAlreadyLoggedIn();

   if(isLoggedIn) {
     await AuthControllers.getUserdata();
   }
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProductListProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteProvider()),
      ],
          child: Builder(
            builder: (context) {

              final themeProvider = context.watch<ThemeProvider>();
              final productListProvider = context.watch<ProductListProvider>();
              final favouriteProvider = context.watch<FavouriteProvider>();

              return MaterialApp(
                debugShowCheckedModeBanner: false,

                theme: ThemeData(
                  brightness: Brightness.light,
                  colorSchemeSeed: Colors.green
                ),
                darkTheme: ThemeData(
                    brightness: Brightness.dark
                ),
                themeMode: themeProvider.themeMode,
                home: widget.isLoggedIn
                        ? ProductListScreen()
                        : LoginScreen(),
              );
            }
          ),
        );
  }
}

