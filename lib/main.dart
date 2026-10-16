import 'package:ecommerce_app_huma_volve/core/navigator_key.dart';
import 'package:ecommerce_app_huma_volve/deep_link/deep_link_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart';
import 'core/theme.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/main_navigation/screens/main_navigation_screen.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  sl<DeepLinkService>().init(); // start listening as early as possible
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      routes: {
        '/home': (_) {
          sl<DeepLinkService>().markAppReady();
          return BlocProvider(
            create: (_) => sl<HomeCubit>()..loadHome(),
            child: const MainNavigationScreen(),
          );
        },
      },
    );
  }
}
