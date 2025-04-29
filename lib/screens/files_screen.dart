import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:html' as html; 
import '../widgets/drawer_menu.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  List<Map<String, String>> uploadedFiles = [];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'xlsx'],
    );

    if (result != null) {
      final file = result.files.first;
      final now = DateTime.now();

      setState(() {
        uploadedFiles.add({
          'name': file.name,
          'extension': file.extension ?? '',
          'date': now.toString().split('.')[0],
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carga de Archivos'),
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: const Icon(Icons.upload_file),
              label: const Text('Seleccionar Archivo (.pdf, .xlsx)'),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: uploadedFiles.isEmpty
                  ? const Center(child: Text('No hay archivos cargados.'))
                  : DataTable(
                      columns: const [
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Extensión')),
                        DataColumn(label: Text('Fecha')),
                      ],
                      rows: uploadedFiles.map((file) {
                        return DataRow(cells: [
                          DataCell(Text(file['name'] ?? '')),
                          DataCell(Text(file['extension'] ?? '')),
                          DataCell(Text(file['date'] ?? '')),
                        ]);
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
