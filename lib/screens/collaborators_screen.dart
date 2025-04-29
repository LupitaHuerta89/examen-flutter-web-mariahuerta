import 'package:flutter/material.dart';
import '../models/collaborator_repository.dart';
import '../models/collaborator.dart';
import '../widgets/drawer_menu.dart';
import '../screens/employees_screen.dart';

/// Pantalla para registrar o editar un colaborador.
/// Permite capturar datos personales y laborales, y navegar de regreso a empleados.
class CollaboratorsScreen extends StatefulWidget {
  final Collaborator? collaborator; // Si es null: nuevo, si no: edición

  const CollaboratorsScreen({super.key, this.collaborator});

  @override
  State<CollaboratorsScreen> createState() => _CollaboratorsScreenState();
}

class _CollaboratorsScreenState extends State<CollaboratorsScreen> {
  static List<Collaborator> collaborators = [];

  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos del formulario
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final rfcController = TextEditingController();
  final curpController = TextEditingController();
  final addressController = TextEditingController();
  final nssController = TextEditingController();
  final startDateController = TextEditingController();
  final contractTypeController = TextEditingController();
  final departmentController = TextEditingController();
  final positionController = TextEditingController();
  final dailySalaryController = TextEditingController();
  final salaryController = TextEditingController();
  final entityKeyController = TextEditingController();

  String? selectedState;

  // Lista de estados de México para el dropdown
  final List<String> statesOfMexico = [
    'Aguascalientes', 'Baja California', 'Baja California Sur', 'Campeche',
    'Chiapas', 'Chihuahua', 'Ciudad de México', 'Coahuila', 'Colima', 'Durango',
    'Estado de México', 'Guanajuato', 'Guerrero', 'Hidalgo', 'Jalisco',
    'Michoacán', 'Morelos', 'Nayarit', 'Nuevo León', 'Oaxaca', 'Puebla',
    'Querétaro', 'Quintana Roo', 'San Luis Potosí', 'Sinaloa', 'Sonora',
    'Tabasco', 'Tamaulipas', 'Tlaxcala', 'Veracruz', 'Yucatán', 'Zacatecas',
  ];

  /// Si se está editando, precarga los datos en los controladores
  @override
  void initState() {
    super.initState();

    if (widget.collaborator != null) {
      nameController.text = widget.collaborator!.name;
      emailController.text = widget.collaborator!.email;
      rfcController.text = widget.collaborator!.rfc;
      curpController.text = widget.collaborator!.curp;
      addressController.text = widget.collaborator!.address;
      nssController.text = widget.collaborator!.nss;
      startDateController.text = widget.collaborator!.startDate;
      contractTypeController.text = widget.collaborator!.contractType;
      departmentController.text = widget.collaborator!.department;
      positionController.text = widget.collaborator!.position;
      dailySalaryController.text = widget.collaborator!.dailySalary;
      salaryController.text = widget.collaborator!.salary;
      entityKeyController.text = widget.collaborator!.entityKey;
      selectedState = widget.collaborator!.state;
    }
  }

  /// Guarda o actualiza la información del colaborador
  void _saveCollaborator() {
    if (_formKey.currentState!.validate()) {
      if (widget.collaborator != null) {
        // Edición existente
        widget.collaborator!
          ..name = nameController.text.trim()
          ..email = emailController.text.trim()
          ..rfc = rfcController.text.trim()
          ..curp = curpController.text.trim()
          ..address = addressController.text.trim()
          ..nss = nssController.text.trim()
          ..startDate = startDateController.text.trim()
          ..contractType = contractTypeController.text.trim()
          ..department = departmentController.text.trim()
          ..position = positionController.text.trim()
          ..dailySalary = dailySalaryController.text.trim()
          ..salary = salaryController.text.trim()
          ..entityKey = entityKeyController.text.trim()
          ..state = selectedState ?? '';
      } else {
        // Nuevo colaborador
        final collaborator = Collaborator(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          rfc: rfcController.text.trim(),
          curp: curpController.text.trim(),
          address: addressController.text.trim(),
          nss: nssController.text.trim(),
          startDate: startDateController.text.trim(),
          contractType: contractTypeController.text.trim(),
          department: departmentController.text.trim(),
          position: positionController.text.trim(),
          dailySalary: dailySalaryController.text.trim(),
          salary: salaryController.text.trim(),
          entityKey: entityKeyController.text.trim(),
          state: selectedState ?? '',
        );
        CollaboratorRepository.collaborators.add(collaborator);
      }

      // Confirmación al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos guardados exitosamente')),
      );

      // Redirecciona a la pantalla de empleados
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EmployeesScreen()),
        );
      });
    }
  }

  /// Interfaz de formulario dividido en secciones
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Colaborador'),
      ),
      drawer: const DrawerMenu(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Sección: Datos Personales
              const Text('📄 Datos Personales', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Divider(),
              const SizedBox(height: 8),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Correo', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo obligatorio';
                  if (!value.contains('@')) return 'Correo inválido';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: rfcController,
                decoration: const InputDecoration(labelText: 'RFC', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: curpController,
                decoration: const InputDecoration(labelText: 'CURP', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Domicilio Fiscal', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: nssController,
                decoration: const InputDecoration(labelText: 'Número de Seguridad Social', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),

              const SizedBox(height: 32),

              // Sección: Datos Laborales
              const Text('💼 Datos Laborales', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Divider(),
              const SizedBox(height: 8),

              TextFormField(
                controller: startDateController,
                decoration: const InputDecoration(labelText: 'Fecha de Inicio Laboral (AAAA-MM-DD)', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: contractTypeController,
                decoration: const InputDecoration(labelText: 'Tipo de Contrato', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: departmentController,
                decoration: const InputDecoration(labelText: 'Departamento', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: positionController,
                decoration: const InputDecoration(labelText: 'Puesto', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: dailySalaryController,
                decoration: const InputDecoration(labelText: 'Salario Diario', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: salaryController,
                decoration: const InputDecoration(labelText: 'Salario', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: entityKeyController,
                decoration: const InputDecoration(labelText: 'Clave Entidad', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              // Dropdown para selección de estado
              DropdownButtonFormField<String>(
                value: selectedState,
                decoration: const InputDecoration(labelText: 'Estado', border: OutlineInputBorder()),
                items: statesOfMexico.map((state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedState = value;
                  });
                },
                validator: (value) => value == null ? 'Selecciona un estado' : null,
              ),

              const SizedBox(height: 32),

              // Botón para guardar datos
              Center(
                child: ElevatedButton(
                  onPressed: _saveCollaborator,
                  child: const Text('Guardar Colaborador'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
