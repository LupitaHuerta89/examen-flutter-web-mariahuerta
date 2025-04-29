import 'package:flutter/material.dart';
import '../screens/files_screen.dart';
import '../screens/collaborators_screen.dart';
import '../screens/employees_screen.dart';
import '../screens/posts_screen.dart';
import '../screens/home_screen.dart';

/// Menú lateral (Drawer) utilizado en toda la aplicación.
/// Permite navegar entre las diferentes pantallas: Inicio, Archivos, Colaboradores, Empleados y Servicios.
class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Cabecera del Drawer con una imagen e información
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            accountName: Text('Sistema de Gestión'),
            accountEmail: Text('Bienvenido'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.indigo),
            ),
          ),
          // Lista de opciones del menú
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.home_outlined,
                  text: 'Inicio',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.upload_file_outlined,
                  text: 'Carga de Archivos',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const FilesScreen()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.people_outline,
                  text: 'Colaboradores',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const CollaboratorsScreen()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.work_outline,
                  text: 'Empleados',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const EmployeesScreen()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.article_outlined,
                  text: 'Servicios',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const PostsScreen()),
                    );
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  icon: Icons.logout_outlined,
                  text: 'Cerrar Sesión',
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Método privado para construir cada elemento del Drawer
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
