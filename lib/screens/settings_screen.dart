import 'package:flutter/material.dart';
import 'package:my_provider/provider/counterProvider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final counterProvider = context.watch<  CounterProvider>();
    final counterProvider2 = context.read<CounterProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Screen'),
      ),
      body:Column(
        children: [
          Text(counterProvider.count.toString()),
          Row(
            children: [
              TextButton(onPressed: (){
               counterProvider2.increment();
              }, child: Icon(Icons.add)) ,
              TextButton(onPressed: (){
               counterProvider2.decrement();
              }, child: Icon(Icons.remove))
            ],
          )
        ],
      ),
    );
  }
}
