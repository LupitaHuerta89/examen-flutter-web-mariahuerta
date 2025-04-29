import 'package:flutter/material.dart';
import '../models/collaborator_repository.dart';
import '../models/collaborator.dart';
import '../widgets/drawer_menu.dart';
import 'collaborators_screen.dart';

/// Pantalla para visualizar la lista de empleados registrados.
/// Incluye búsqueda dinámica, eliminación lógica y navegación a edición.
class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  // Lista que se muestra, basada en la búsqueda
  List<Collaborator> displayedCollaborators = [];

  // Controlador para el campo de búsqueda
  final searchController = TextEditingController();

  /// Se actualiza la lista al entrar a la pantalla
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      displayedCollaborators = List.from(CollaboratorRepository.collaborators);
    });
  }

  /// Función para filtrar colaboradores por nombre, RFC o CURP
  void _search(String query) {
    final lowerQuery = query.toLowerCase();

    final results = CollaboratorRepository.collaborators.where((collaborator) {
      return collaborator.isActive &&
          (collaborator.name.toLowerCase().contains(lowerQuery) ||
           collaborator.rfc.toLowerCase().contains(lowerQuery) ||
           collaborator.curp.toLowerCase().contains(lowerQuery));
    }).toList();

    setState(() {
      displayedCollaborators = results;
    });
  }

  /// Eliminación lógica: marca al colaborador como inactivo
  void _deleteCollaborator(Collaborator collaborator) {
    setState(() {
      collaborator.isActive = false;
    });
  }

  /// Interfaz principal que contiene barra de búsqueda y tabla de resultados
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empleados'),
      ),
      drawer: const DrawerMenu(),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Campo de búsqueda
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Buscar por nombre, RFC o CURP',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _search,
            ),
            const SizedBox(height: 20),

            // Tabla de datos en contenedor con estilo
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.indigo.shade100),
                    dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),

                    // Encabezados de la tabla
                    columns: const [
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text('Correo')),
                      DataColumn(label: Text('RFC')),
                      DataColumn(label: Text('CURP')),
                      DataColumn(label: Text('Acciones')),
                    ],

                    // Filas dinámicas basadas en la lista de colaboradores activos
                    rows: displayedCollaborators
                        .where((c) => c.isActive)
                        .map((collaborator) {
                          return DataRow(
                            cells: [
                              DataCell(Text(collaborator.name)),
                              DataCell(Text(collaborator.email)),
                              DataCell(Text(collaborator.rfc)),
                              DataCell(Text(collaborator.curp)),

                              // Acciones: editar o eliminar
                              DataCell(Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.indigo),
                                    tooltip: 'Editar',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CollaboratorsScreen(collaborator: collaborator),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    tooltip: 'Eliminar',
                                    onPressed: () {
                                      _deleteCollaborator(collaborator);
                                    },
                                  ),
                                ],
                              )),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
