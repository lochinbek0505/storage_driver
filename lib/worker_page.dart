import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // Import path_provider package

class WorkersPage extends StatefulWidget {
  const WorkersPage({super.key});

  @override
  State<WorkersPage> createState() => _WorkersPageState();
}

class _WorkersPageState extends State<WorkersPage> {
  late File _selectedFile;

  Future<void> _uploadFile(File _selectedFile1) async {
    try {
      if (_selectedFile1 != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference storageRef = storage.ref().child(
            'uploads/ishchi_xodim.xlsx'); // Change the file extension as needed
        await storageRef.putFile(_selectedFile1);
        final snackBar = SnackBar(
          content: Text('FILE YUKLANDI!'),
        );

        // Show the snackbar
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('File uploaded successfully.');
      } else {
        final snackBar = SnackBar(
          content: Text('FILE TANLANMADI!'),
        );

        // Show the snackbar
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('No file selected.');
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Error uploading file: $e'),
      );

      // Show the snackbar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Error uploading file: $e');
    }
  }

  Future<void> _downloadFile() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(
          'uploads/ishchi_xodim.xlsx'); // Change this to match your storage path
      Directory? directory =
          await getDownloadsDirectory(); // Get downloads directory
      if (directory != null) {
        File downloadToFile = File(
            '${directory.path}/ishchi_xodim.xlsx'); // File path in downloads directory
        await ref.writeToFile(downloadToFile);
        final snackBar = SnackBar(
          content: Text('FILE YUKLAB OLINDI'),
        );

        // Show the snackbar
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('File downloaded successfully.');
      } else {
        final snackBar = SnackBar(
          content: Text('KERAKLI FILE TOPILMADI !'),
        );

        // Show the snackbar
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Error uploading file: $e'),
      );

      // Show the snackbar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Error uploading file: $e');
    }
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'xlsx',
        'xls'
      ], // Add any other Excel file extensions you want to allow
    );
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _uploadFile(_selectedFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ISHCHI - XODIM'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await _selectFile();
              },
              child: Text('Jadvalni ilovaga yuklash'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _downloadFile();
              },
              child: Text('Jadvalni kompyuterga  yuklab olish'),
            ),
          ],
        ),
      ),
    );
  }
}
