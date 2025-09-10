import 'package:flutter/material.dart';

import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/perfil_screen.dart';
import 'screens/politica_privacidade_screen.dart';
import 'screens/termos_uso_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CORAÇÃO GENEROSO', 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFD32F2F),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD32F2F),
          foregroundColor: Colors.white,
          elevation: 3,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD32F2F)),
          ),
          labelStyle: TextStyle(color: Color(0xFF616161)),
          floatingLabelStyle: TextStyle(color: Color(0xFFD32F2F)),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFD32F2F),
          selectionColor: Color(0xFFFFCDD2),
          selectionHandleColor: Color(0xFFD32F2F),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/telaInicial': (context) => const DashboardScreen(),
        '/perfil': (context) => const PerfilScreen(),
        '/politica-privacidade': (context) => const PoliticaPrivacidadeScreen(),
        '/termos-uso': (context) => const TermosUsoScreen(),
      },
    );
  }
}