import 'package:flutter/material.dart';
import 'package:my_gestor/app/components/my_drawer.dart';

class Dashboard extends StatelessWidget {
const Dashboard({ super.key, required this.child, });
final Widget child;
  @override
  Widget build(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    if(width < 600){
      return Scaffold(
        appBar: AppBar(
          title: Text('My Gestor'),
        ),
        drawer: MyDrawer(),
        body: child,
      );
    }else {
      return Scaffold(
      body:Row(children: [
        MyDrawer(),
        Expanded(child: child),
      ],)
    );
    }
  }
}