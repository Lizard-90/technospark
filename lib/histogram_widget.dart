import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:technospark/list.dart';
import 'package:technospark/main.dart';
import 'package:technospark/pdf_generating.dart';
import 'package:technospark/test.dart';
import 'package:logger/logger.dart';
import 'dart:ui' as ui;

var logger = Logger();

class HistogramWidget extends StatefulWidget {
  HistogramWidget({super.key, required this.interval});

  Duration interval;

  @override
  State<HistogramWidget> createState() => _HistogramWidgetState();
}

class _HistogramWidgetState extends State<HistogramWidget> {
  late List<DataPoint> intervalData;
  @override
  void initState() {
    // dataFut = loadCSV();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    intervalData = getIntervalData(dataPointList, widget.interval);
    if (widget.interval == interval5Min) {
      interval5MinAverageSpeed =
          intervalData.map((point) => point.speed).reduce((a, b) => a + b) /
              intervalData.length;
      intervalData5 = intervalData;
    } else if (widget.interval == interval10Min) {
      interval10MinAverageSpeed =
          intervalData.map((point) => point.speed).reduce((a, b) => a + b) /
              intervalData.length;
      intervalData10 = intervalData;
    }
    return Center(
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        primaryYAxis: NumericAxis(),
        series: <ChartSeries>[
          ColumnSeries<DataPoint, DateTime>(
            dataSource: intervalData,
            xValueMapper: (DataPoint dataPoint, _) => dataPoint.time,
            yValueMapper: (DataPoint datapoint, _) => datapoint.speed,
            // xAxisName: "Time",
            yAxisName: "AvarageSpeed",

            // dataLabelSettings: DataLabelSettings(isVisible: true),
            // borderWidth: 0.4,
          ),
        ],
      ),
    );
  }
}
