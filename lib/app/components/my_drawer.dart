import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final String? currentRoute = GoRouterState.of(context).fullPath;
    return Drawer(
      width: 200,
      child: Column(children: _options.map((op) {
          final bool isSelected = currentRoute == op['route'];
          return ListTile(
            leading: Icon(
              op['icon'] as IconData,
              color: isSelected ? Colors.blue : Colors.black,
            ),
            title: Text(
              op['title'] as String,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            onTap: () {
              context.go(op['route'] as String);
            },
          );
        }).toList(),),);
  }   
}
List<Map<String, Object>> _options =[

  {
    'title': 'Company',
    'icon': Icons.business,
    'route': '/company',
  },
  {
    'title': 'Register',
    'icon': Icons.app_registration_rounded,
    'route': '/register',
  },
  {
      'title': 'Grafics',
      'icon': Icons.stacked_bar_chart_outlined,
      'route': '/stats',
    },
  {
    'title': 'Profile',
    'icon': Icons.person,
    'route': '/profile',
  },  {
    'title': 'Tools',
    'icon': Icons.toggle_on_sharp,
    'route': '/tools',
  },
];