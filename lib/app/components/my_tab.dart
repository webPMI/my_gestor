import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
const MyTab({ super.key, required this.tabs,});
final Map<String,Widget> tabs;
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            tabs: tabs.keys.map((e) => Tab(text: e)).toList(),
            onTap: (value) {
            },
          ),
          Expanded(
            child: TabBarView(
              children:tabs.values.map((tab) {
        return tab;
              }).toList(),
            ),
          ),
        ],
      ),

    );
  }
}