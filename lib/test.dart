import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logger/logger.dart';
import 'package:csv/csv.dart';

var logger = Logger();

List<DataPoint> dataPointList = [];
Duration interval5Min = Duration(minutes: 5);
Duration interval10Min = Duration(minutes: 10);
double totalAverageSpeed = 0;
double interval5MinAverageSpeed = 0;
double interval10MinAverageSpeed = 0;
String _rawData = '';

class DataPoint {
  final DateTime time;
  final double speed;

  DataPoint(this.time, this.speed);

  @override
  String toString() {
    return '\n DataPoint(time: ${time.toString()}, speed: $speed) ';
  }
}

void printf() {
  logger.i("entered in");
}

Future readCSVFromFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType
            .custom, // Выбираем тип файла (в данном случае, пользователь может выбрать любой файл)
        allowedExtensions: ['csv']);

    if (result != null) {
      File file = File(result.files.single.path!);

      _rawData = await file.readAsString();
    } // Указываем разрешенные расширения файлов (только CSV)
  } catch (e) {
    logger.e('Ошибка при чтении файла: $e');
  }

  List<List<dynamic>> _listData = CsvToListConverter().convert(_rawData);

  for (int i = 1; i < _listData.length; i++) {
    DateTime time = DateFormat('HH:mm:ss').parse(_listData[i][0]);
    double speed = _listData[i][1];
    DataPoint dataPoint = DataPoint(time, speed);
    dataPointList.add(dataPoint);
    // logger.i('dataPointList = ${dataPointList}');
  }
  dataPointList.sort((a, b) => a.time.compareTo(b.time));
  totalAverageSpeed =
      dataPointList.map((point) => point.speed).reduce((a, b) => a + b) /
          dataPointList.length;

  logger.i("dataPointList = ${dataPointList}");
}

List<DataPoint> getIntervalData(List<DataPoint> data, Duration interval) {
  List<DataPoint> intervalData = [];
  DateTime startTime = data.first.time;
  DateTime endTime = data.last.time;
  double sumSpeed = 0;
  int count = 0;

  for (var point in data) {
    Duration timeDifference = point.time.difference(startTime);

    if (timeDifference <= interval) {
      sumSpeed += point.speed;
      count++;
    } else {
      if (count > 0) {
        double averageSpeed = sumSpeed / count;
        intervalData.add(DataPoint(startTime, averageSpeed));
      }

      // Перемещаем начальное время на следующий интервал
      startTime = startTime.add(interval);

      // Проверяем, если следующее начальное время выходит за пределы общего времени,
      // то устанавливаем его равным времени окончания
      if (startTime.isAfter(endTime)) {
        startTime = endTime;
      }

      sumSpeed = point.speed;
      count = 1;
    }
  }

  // Добавляем последний интервал
  if (count > 0) {
    double averageSpeed = sumSpeed / count;
    intervalData.add(DataPoint(startTime, averageSpeed));
  }

  return intervalData;
}

class Refresher with ChangeNotifier {
  void refresher() {
    logger.i('provider.refresher');
    notifyListeners();
  }
}
