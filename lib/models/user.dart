/// Clase que representa a un Usuario en el sistema.
/// Contiene la información necesaria para autenticación y recuperación de contraseña.
class User {
  /// Correo electrónico del usuario
  String email;

  /// Contraseña del usuario
  String password;

  /// RFC (Registro Federal de Contribuyentes) del usuario
  String rfc;

  /// Constructor de la clase User
  User({
    required this.email,
    required this.password,
    required this.rfc,
  });
}
