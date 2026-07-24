import 'package:flutter/material.dart';
import 'package:my_provider/apiServices/api_caller.dart';
import 'package:my_provider/data/utils/urls.dart';
import 'package:my_provider/screens/product_list_screen.dart';
import 'package:my_provider/ui/controllers/auth_controllers.dart';
import 'package:my_provider/widgets/snack_bar_massage.dart';
import '../models/user_model.dart';
import '../widgets/centered_progress_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loginProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Login'),
              SizedBox(height: 20),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                  hintText: 'User Name',
                ),
                validator:(String? value){
                  String inputText = value ?? '';
                  if(inputText.trim().isEmpty){
                    return 'Enter userName';
                  }
                  return null;
                },


              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(hintText: 'Password'),
                validator: (String? value) {
                  if((value?.length ?? 0) < 6 ){
                    return 'Enter a password more than 6 character';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _loginProgress == false,
                    replacement: CenterProgressIndicator(),
                    child: FilledButton(onPressed: _onTapLoginButton,
                        child: Text('Login')),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _onTapLoginButton() {
    if(_formKey.currentState!.validate()) {
      _login();
    }
  }
  Future<void> _login() async {
    setState(() {
      _loginProgress = true;
    });
    Map<String, dynamic> requestBody ={
      'username': _userNameController.text.trim(),
      'password': _passwordController.text.trim(),

    };

    final ApiResponse response = await ApiCaller.postRequest(url: Urls.loginUrl,
    body: requestBody);

    setState(() {
      _loginProgress = false;
    });

    if(response.isSuccess && response.responseData != null){
      UserModel model = UserModel.fromJson(response.responseData);

      String accessToken = response.responseData['accessToken'];

      try {
        await AuthControllers.saveUserdata(model, accessToken);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> ProductListScreen()),
            (predicate) => false);
      } on Exception catch (e) {
        print('Error: $e');
      }
    }else {
      showSnackBarMessage(context, response.errorMassage ??  'Something went wrong');
    }

  }
  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}






