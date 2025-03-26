import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gestor/app/components/my_button.dart';

import '../components/my_textfield.dart';

class Login extends StatelessWidget {
const Login({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
              const Text('Log in',),
              const MyTextField(
                width: 300,
                hintText: 'Email',),
              const MyTextField(
                width: 300,
                hintText: 'Password',),
                    
              MyButton(
                margin: 10,
                padding: 2,
                onPressed: () {
                 context.go('/company');
                },
              ),
            ],),
          ),
        ),
      ),
    );
  }
}