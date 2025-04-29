import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/drawer_menu.dart';

/// Pantalla que muestra publicaciones (posts) obtenidas desde una API externa.
/// Permite crear, editar y eliminar publicaciones.
class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<dynamic> posts = [];     // Lista de publicaciones
  bool isLoading = true;        // Indicador de carga

  /// Al iniciar, se obtienen las publicaciones
  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  /// Método GET: Consulta de publicaciones desde jsonplaceholder
  Future<void> fetchPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts?userId=1');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          posts = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Error al cargar publicaciones');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Método POST: Crear una nueva publicación
  Future<void> createPost(String title, String body) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    try {
      final response = await http.post(
        url,
        body: {
          'title': title,
          'body': body,
          'userId': '1',
        },
      );

      if (response.statusCode == 201) {
        final newPost = json.decode(response.body);
        setState(() {
          posts.insert(0, newPost); // Se añade al inicio
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Publicación creada exitosamente')),
        );
      } else {
        throw Exception('Error al crear publicación');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  /// Método PUT: Actualizar una publicación existente
  Future<void> updatePost(int id, String title, String body) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/$id');
    try {
      final response = await http.put(
        url,
        body: {
          'id': '$id',
          'title': title,
          'body': body,
          'userId': '1',
        },
      );

      if (response.statusCode == 200) {
        final updatedPost = json.decode(response.body);
        setState(() {
          final index = posts.indexWhere((p) => p['id'] == id);
          if (index != -1) {
            posts[index] = updatedPost;
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Publicación actualizada exitosamente')),
        );
      } else {
        throw Exception('Error al actualizar publicación');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  /// Método DELETE: Eliminar una publicación
  Future<void> deletePost(int id) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/$id');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        setState(() {
          posts.removeWhere((p) => p['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Publicación eliminada exitosamente')),
        );
      } else {
        throw Exception('Error al eliminar publicación');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  /// Cuadro de diálogo para crear una publicación
  void _openCreateDialog() {
    final _formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Crear Publicación'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bodyController,
                  decoration: const InputDecoration(labelText: 'Contenido'),
                  maxLines: 4,
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
                createPost(titleController.text.trim(), bodyController.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }

  /// Cuadro de diálogo para editar una publicación existente
  void _openEditDialog(Map<String, dynamic> post) {
    final _formKey = GlobalKey<FormState>();
    final titleController = TextEditingController(text: post['title']);
    final bodyController = TextEditingController(text: post['body']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Publicación'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bodyController,
                  decoration: const InputDecoration(labelText: 'Contenido'),
                  maxLines: 4,
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
                updatePost(post['id'], titleController.text.trim(), bodyController.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Guardar Cambios'),
          ),
        ],
      ),
    );
  }

  /// Interfaz principal con lista de publicaciones y botón flotante
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios - Publicaciones'),
      ),
      drawer: const DrawerMenu(),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : posts.isEmpty
              ? const Center(child: Text('No hay publicaciones disponibles.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post['title'],
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(post['body'], style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.indigo),
                                  tooltip: 'Editar',
                                  onPressed: () => _openEditDialog(post),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  tooltip: 'Eliminar',
                                  onPressed: () => deletePost(post['id']),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateDialog,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
