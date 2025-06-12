import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/components/button.dart';
import 'package:graduation_project/models/styles.dart';

import '../../models/file_upload_model.dart';
import '../../Services/file_upload_service.dart';

class FileUploadPage extends StatefulWidget {
  const FileUploadPage({Key? key}) : super(key: key);

  @override
  State<FileUploadPage> createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  FileUploadModel? _selectedFile;
  bool _isUploading = false;

  final FileUploadService _fileUploadService = FileUploadService(
      apiUrl: 'http://10.100.102.6:2030/cv/analyze'); // Replace with your API

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = FileUploadModel(filePath: result.files.single.path!);
      });
      _showSnackBar('PDF selected: ${result.files.single.name}', Colors.green);
    } else {
      _showSnackBar('No file selected or invalid file type.', Colors.red);
    }
  }

Future<void> _uploadFile() async {
  if (_selectedFile == null) {
    _showSnackBar('No file selected!', Colors.red);
    return;
  }

  setState(() {
    _isUploading = true;
  });

  File file = File(_selectedFile!.filePath);
  String userId = "12345yu";
  
  try {
    Response response = await _fileUploadService.uploadFile(file,userId);
    if (response.statusCode == 200) {
      _showSnackBar('File uploaded successfully!', Colors.green);
    } else {
      _showSnackBar('Failed to upload file. Status: ${response.statusCode}', Colors.red);
    }
  } catch (e) {
    _showSnackBar('Error: $e', Colors.red);
  } finally {
    setState(() {
      _isUploading = false;
    });
  }
}


  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildFilePreview() {
    if (_selectedFile == null) return const SizedBox();

    final fileName = _selectedFile!.filePath.split('/').last;

    // Just show the PDF icon and filename
    return Column(
      children: [
        const Icon(Icons.picture_as_pdf, size: 200, color: Colorize.ThirdColor),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            fileName,
            style: TextStyle(
                color: Colorize.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'File Upload',
          style: TextStyle(color: Colorize.white),
        ),
        backgroundColor: Colorize.SecondColor,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colorize.Theme),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
...(_selectedFile != null
    ? [
        const Spacer(flex: 1),
        _buildFilePreview(),
        const Spacer(flex: 1),
      ]
    : [
        const Spacer(flex: 3),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Ready to grow your career? Upload your CV and let's uncover powerful ways to improve it. Your next opportunity starts with one step — pick your file and level up!",
            style: TextStyle(
              color: Colorize.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(flex: 4),
      ]),
Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  text: _selectedFile != null
                      ? "Select PDF File"
                      : "Select PDF File",
                  onpressed: _pickFile,
                  spacer: _selectedFile != null ? false : true,
                ),
                if (_selectedFile != null) ...[
                  SizedBox(width: 20),
                  Button(
                    onpressed: _isUploading ? null : _uploadFile,
                    text: 'Upload PDF',
                    child: _isUploading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Upload File'),
                  ),
                ],
              ],
            ),
            SizedBox(height: _selectedFile != null ? 60 : 20),
          ],
        ),
      ),
    );
  }
}
