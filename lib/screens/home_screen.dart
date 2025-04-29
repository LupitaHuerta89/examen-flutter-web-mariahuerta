import 'package:flutter/material.dart';
import '../widgets/drawer_menu.dart';

/// Pantalla principal del sistema (Home).
/// Muestra una bienvenida e indica cómo navegar usando el menú lateral.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar superior con título
      appBar: AppBar(
        title: const Text('Panel Principal'),
      ),

      // Menú lateral reutilizable
      drawer: const DrawerMenu(),

      // Cuerpo centrado con ícono y texto
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícono representativo del panel
              const Icon(
                Icons.dashboard_customize_outlined,
                size: 100,
                color: Colors.indigo,
              ),
              const SizedBox(height: 24),

              // Texto de bienvenida
              const Text(
                'Bienvenido al sistema',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Instrucción para el usuario
              const Text(
                'Desde aquí puedes navegar entre las diferentes funcionalidades utilizando el menú lateral.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
