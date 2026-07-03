import 'package:flutter/material.dart';
import 'package:my_provider/provider/counterProvider.dart';
import 'package:my_provider/screens/settings_screen.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Counter'),
      ),
      body: Column(
        children: [
          Text(context.watch<CounterProvider>().count.toString()),
          Row(
            children: [
              TextButton(onPressed: (){
                context.read<CounterProvider>().increment();
              }, child: Icon(Icons.add)) ,
              TextButton(onPressed: (){
                context.read<CounterProvider>().decrement();
              }, child: Icon(Icons.remove)),
              TextButton(onPressed: (){
                context.read<CounterProvider>().reset();
              }, child: Icon(Icons.restore)),
            ],
          ),
          FilledButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
          }, child: Icon(Icons.navigate_next)),

          IconButton(onPressed: (){
            context.read<ThemeProvider>().toggleThemeMode();
          }, icon: Icon(Icons.sunny)),
        ],
      ),
    );
  }
}
