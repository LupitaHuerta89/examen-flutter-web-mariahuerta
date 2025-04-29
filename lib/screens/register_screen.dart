import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/user_repository.dart';

/// Pantalla de registro de usuarios.
/// Permite registrar un nuevo usuario con validación de campos y verificación de duplicados.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para cada campo del formulario
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final rfcController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Valida la estructura del RFC según el patrón requerido en México.
  String? validateRFC(String? value) {
    if (value == null || value.isEmpty) return 'RFC requerido';
    if (value.length != 13 && value.length != 12) return 'RFC debe tener 12 o 13 caracteres';

    final pattern = r'^([A-ZÑ&]{3,4})\d{6}([A-Z\d]{3})?$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) return 'Formato de RFC inválido';
    return null;
  }

  /// Valida el formulario, registra al usuario y redirige al login si es exitoso.
  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final rfc = rfcController.text.trim();
      final password = passwordController.text.trim();

      // Verifica si el usuario ya está registrado
      final exists = UserRepository.users.any((u) => u.email == email || u.rfc == rfc);
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('El RFC o correo ya está registrado')),
        );
        return;
      }

      // Agrega el nuevo usuario a la lista simulada
      UserRepository.users.add(User(email: email, password: password, rfc: rfc));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );

      // Redirige al login después del registro exitoso
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  /// Construcción del formulario de registro con validaciones y estilo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 40),
                const Icon(Icons.person_add_alt_1, size: 100, color: Colors.indigo),
                const SizedBox(height: 20),
                const Text(
                  'Crear Cuenta',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Campo de correo electrónico
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Correo electrónico'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Correo requerido';
                    if (!value.contains('@')) return 'Formato de correo inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo de RFC
                TextFormField(
                  controller: rfcController,
                  decoration: const InputDecoration(labelText: 'RFC'),
                  validator: validateRFC,
                ),
                const SizedBox(height: 20),

                // Campo de contraseña
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  validator: (value) => value == null || value.isEmpty ? 'Contraseña requerida' : null,
                ),
                const SizedBox(height: 20),

                // Campo de confirmación de contraseña
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Confirmar Contraseña'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Confirmación requerida';
                    if (value != passwordController.text) return 'Las contraseñas no coinciden';
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Botón para registrar
                ElevatedButton(
                  onPressed: _registerUser,
                  child: const Text('Registrar'),
                ),
                const SizedBox(height: 10),

                // Link para redirigir al login
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('¿Ya tienes cuenta? Inicia sesión aquí'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
