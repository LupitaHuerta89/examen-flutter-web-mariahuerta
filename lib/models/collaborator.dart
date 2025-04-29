/// Clase que representa un Colaborador en el sistema.
/// Contiene información personal y laboral de cada colaborador.
class Collaborator {
  /// Nombre completo del colaborador
  String name;

  /// Correo electrónico del colaborador
  String email;

  /// Registro Federal de Contribuyentes (RFC) del colaborador
  String rfc;

  /// Clave Única de Registro de Población (CURP) del colaborador
  String curp;

  /// Domicilio fiscal del colaborador
  String address;

  /// Número de Seguridad Social (NSS) del colaborador
  String nss;

  /// Fecha de inicio laboral en formato AAAA-MM-DD
  String startDate;

  /// Tipo de contrato del colaborador
  String contractType;

  /// Departamento al que pertenece el colaborador
  String department;

  /// Puesto o cargo que desempeña el colaborador
  String position;

  /// Salario diario del colaborador
  String dailySalary;

  /// Salario mensual o anual del colaborador
  String salary;

  /// Clave de la entidad federativa de residencia
  String entityKey;

  /// Estado o entidad federativa del colaborador
  String state;

  /// Indica si el colaborador está activo o inactivo
  bool isActive;

  /// Constructor de la clase Collaborator
  Collaborator({
    required this.name,
    required this.email,
    required this.rfc,
    required this.curp,
    required this.address,
    required this.nss,
    required this.startDate,
    required this.contractType,
    required this.department,
    required this.position,
    required this.dailySalary,
    required this.salary,
    required this.entityKey,
    required this.state,
    this.isActive = true,
  });
}
