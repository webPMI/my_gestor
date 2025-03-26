

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        appBar: AppBar(actions: [
          IconButton(icon: Icon(Icons.login), onPressed: () {
        context.go('/login');
          },)
        ],),
        body: Center(
        child: SingleChildScrollView(
          child: Column(
          children: [
        
          Text('Wellcome'),
        ],),),
      ),),
    );
  }
}