// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:csv/csv.dart';
// import 'package:intl/intl.dart';

// class DataPoint {
//   DateTime time;
//   double speed;

//   DataPoint(this.time, this.speed);
// }

// Future<List<DataPoint>> readCSVFromFile() async {
//   List<DataPoint> data = [];

//   try {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom, // Выбираем тип файла (в данном случае, пользователь может выбрать любой файл)
//       allowedExtensions: ['csv'], // Указываем разрешенные расширения файлов (только CSV)
//     );

//     if (result != null) {
//       File file = File(result.files.single.path);

//       String csvData = await file.readAsString();

//       List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);

     
//     }
//   } catch (e) {
//     print('Ошибка при чтении файла: $e');
//   }

//   return data;
// }


//   // Загрузка данных из CSV-файла
//   // List<DataPoint> data = await readCSVFromFile();

  
