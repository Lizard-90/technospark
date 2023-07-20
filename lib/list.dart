// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:csv/csv.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:technospark/test.dart';







//   // Загрузка данных из CSV-файла
//   String csvAssetPath = 'assets/data.csv';
//   List<DataPoint> data = await readCSVFromAsset(csvAssetPath);

//   // Разделение данных на интервалы (5 минут и 10 минут)
//   Duration interval5Min = Duration(minutes: 5);
//   Duration interval10Min = Duration(minutes: 10);

//   List<DataPoint> intervalData5Min = getIntervalData(data, interval5Min);
//   List<DataPoint> intervalData10Min = getIntervalData(data, interval10Min);

//   // Построение гистограммы для интервала 5 минут
//   runApp(MyApp(intervalData5Min, '5 Minutes Interval'));

//   // Построение гистограммы для интервала 10 минут
//   runApp(MyApp(intervalData10Min, '10 Minutes Interval'));


  // graphics.drawString(
  //     'Средняя скорость за 5 минут: ${interval5MinAverageSpeed.toStringAsFixed(2)}',
  //     font,
  //     bounds: Rect.fromLTWH(0, y, 500, lineHeight));
  // y += lineHeight;

  // graphics.drawString(
  //     'Процентное соотношение от общей средней скорости: ${(interval5MinAverageSpeed / totalAverageSpeed * 100).toStringAsFixed(2)}%',
  //     font,
  //     bounds: Rect.fromLTWH(0, y, 500, lineHeight));
  // y += lineHeight;

  // graphics.drawString(
  //     'Средняя скорость за 10 минут: ${interval10MinAverageSpeed.toStringAsFixed(2)}',
  //     font,
  //     bounds: Rect.fromLTWH(0, y, 500, lineHeight));
  // y += lineHeight;

  // graphics.drawString(
  //     'Процентное соотношение от общей средней скорости: ${(interval10MinAverageSpeed / totalAverageSpeed * 100).toStringAsFixed(2)}%',
  //     font,
  //     bounds: Rect.fromLTWH(0, y, 500, lineHeight));
  // y += lineHeight;