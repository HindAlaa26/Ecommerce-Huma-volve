import 'package:ecommerce_app_huma_volve/network/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/home/services/home_service.dart';
import 'features/main_navigation/screens/main_navigation_screen.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      routes: {
        '/home': (_) => BlocProvider(
              create: (_) => HomeCubit(HomeService(ApiClient()))..loadHome(),
              child: const MainNavigationScreen(),
            ),
      },
    );
  }
}
