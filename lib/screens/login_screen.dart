import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/user_repository.dart';
import 'register_screen.dart';
import 'home_screen.dart';

/// Pantalla de inicio de sesión para el sistema.
/// Permite al usuario iniciar sesión, recuperar contraseña o ir a registrarse.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para los campos de email y contraseña
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Valida las credenciales ingresadas y navega al Home si son correctas.
  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final user = UserRepository.users.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => User(email: '', password: '', rfc: ''),
    );

    if (user.email.isNotEmpty) {
      // Credenciales válidas, navega al Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      // Usuario o contraseña incorrectos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo o contraseña incorrectos')),
      );
    }
  }

  /// Abre un cuadro de diálogo para restablecer la contraseña
  /// validando el correo y RFC proporcionados.
  void _openPasswordResetDialog() {
    final _formKey = GlobalKey<FormState>();
    final emailResetController = TextEditingController();
    final rfcResetController = TextEditingController();
    final newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restablecer Contraseña'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailResetController,
                  decoration: const InputDecoration(labelText: 'Correo'),
                  validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: rfcResetController,
                  decoration: const InputDecoration(labelText: 'RFC'),
                  validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: newPasswordController,
                  decoration: const InputDecoration(labelText: 'Nueva Contraseña'),
                  obscureText: true,
                  validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final email = emailResetController.text.trim();
                final rfc = rfcResetController.text.trim();
                final newPassword = newPasswordController.text.trim();

                final index = UserRepository.users.indexWhere(
                  (u) => u.email == email && u.rfc == rfc,
                );

                if (index != -1) {
                  UserRepository.users[index].password = newPassword;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Contraseña actualizada exitosamente')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Correo y RFC no coinciden')),
                  );
                }
              }
            },
            child: const Text('Actualizar'),
          ),
        ],
      ),
    );
  }

  /// Construcción del diseño visual de la pantalla de login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 50),
                const Icon(Icons.lock_outline, size: 100, color: Colors.indigo),
                const SizedBox(height: 24),
                const Text(
                  'Bienvenido',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Campo de correo
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Correo'),
                  validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
                ),
                const SizedBox(height: 20),

                // Campo de contraseña
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
                ),
                const SizedBox(height: 30),

                // Botón para iniciar sesión
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: const Text('Ingresar'),
                ),
                const SizedBox(height: 20),

                // Link para restablecer contraseña
                TextButton(
                  onPressed: _openPasswordResetDialog,
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),

                // Link para ir a registrarse
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: const Text('¿No tienes cuenta? Regístrate aquí'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
