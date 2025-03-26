import 'package:go_router/go_router.dart';
import 'package:my_gestor/app/dashboard/profile/profile_screen.dart';
import 'package:my_gestor/app/dashboard/tools/tools_screen.dart';
import '../dashboard/company/company_screen.dart';
import '../dashboard/dashboard.dart';
import '../dashboard/register/register_screen.dart';
import '../dashboard/stats/stats_screen.dart';
import '../public/home_page.dart';
import '../public/login.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/',builder: (context, state) =>  const HomePage(),),
    GoRoute(path: '/login',builder: (context, state) =>  const Login(),),
     ShellRoute(   
      builder: (context,state,child)=>Dashboard(child: child,),
      routes: userRoutes)
    ]);

    final  userRoutes =  [
      GoRoute(path: '/tools',builder: (context, state) =>  const ToolsScreen(),),
      GoRoute(path: '/company',builder: (context, state) =>  const CompanyScreen(),),
   GoRoute(path: '/register',builder: (context, state) =>  const RegisterScreen(),),
      GoRoute(path: '/stats',builder: (context, state) =>  const StatsScreen(),),
      GoRoute(path: '/profile',builder: (context, state) =>  const ProfileScreen(),),
      
    ];
