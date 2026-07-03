import 'package:flutter/material.dart';
import 'package:my_provider/provider/login_provider.dart';
import 'package:my_provider/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Login'),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: (){
                  context.read<LoginProvider>().login();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                }, child: Text('Login')))
          ],
        ),
      ),
    );
  }
}
