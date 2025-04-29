// /lib/models/user_repository.dart

import 'user.dart';

/// Clase que simula un repositorio de usuarios en memoria.
/// Se utiliza para almacenar y gestionar la información de los usuarios registrados.
class UserRepository {
  /// Lista estática que contiene todos los usuarios registrados en el sistema.
  /// 
  /// Inicialmente contiene un usuario administrador de prueba.
  static List<User> users = [
    User(
      email: 'admin@example.com',
      password: '1234',
      rfc: 'ABCD123456XXX',
    ),
  ];
}
