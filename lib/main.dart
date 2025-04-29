import 'package:flutter/material.dart';

// Importamos las pantallas principales de la app
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';

/// Función principal de inicio. Ejecuta la aplicación Flutter.
void main() {
  runApp(const MyApp());
}

/// Widget raíz de la aplicación. Configura temas, rutas y título.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Flutter Web', // Título de la app en el navegador
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de debug

      // Definición del tema global
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Fondo claro general
        primarySwatch: Colors.indigo, // Color principal para botones, AppBar, etc.

        // Estilos para AppBar en toda la app
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          elevation: 0,
        ),

        // Estilo global para botones elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        // Estilo global para inputs/textfields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.indigo),
          ),
        ),
      ),

      // Ruta inicial al iniciar la app
      initialRoute: '/login',

      // Rutas nombradas utilizadas en la aplicación
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
