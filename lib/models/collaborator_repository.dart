// /lib/models/collaborator_repository.dart

import 'collaborator.dart';

/// Clase que simula un repositorio en memoria para almacenar los colaboradores.
/// 
/// Esta clase mantiene una lista estática de colaboradores
/// y se utiliza para operaciones como agregar, editar o eliminar colaboradores.
class CollaboratorRepository {
  /// Lista estática de colaboradores registrados.
  static List<Collaborator> collaborators = [];
}
