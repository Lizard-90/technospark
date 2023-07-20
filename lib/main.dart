import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:technospark/histogram_widget.dart';
import 'package:technospark/pdf_generating.dart';
import 'package:technospark/statWidget.dart';
import 'package:technospark/test.dart';

var logger = Logger();
List<DataPoint> intervalData5 = [];
List<DataPoint> intervalData10 = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechSpark',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<DataPoint> data = [];

  // Future<void> loadDataFromCSV() async {

  //   List<DataPoint> newData = await readCSVFromFile();

  //   setState(() {
  //     dataPointList = newData;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TechSpark'),
        centerTitle: true,
      ),
      body: MultiProvider(
        providers: [
          ListenableProvider<Refresher>(
            create: (context) => Refresher(),
          )
        ],
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    readCSVFromFile();
                  },
                  child: Text("Load Data from CSV")),
              FutureBuilder(
                // future: readCSVFromFile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        HistogramWidget(interval: Duration(minutes: 5)),
                        HistogramWidget(interval: Duration(minutes: 10)),
                        StatisticWidget(
                          label: "totalAverageSpeed",
                          data: totalAverageSpeed.toString(),
                        ),
                        StatisticWidget(
                          label: "interval5MinAverageSpeed",
                          data: interval5MinAverageSpeed.toString(),
                        ),
                        StatisticWidget(
                            label: "interval10MinAverageSpeed",
                            data: interval10MinAverageSpeed.toString()),
                        StatisticWidget(
                            label: "Percentage of Avg Speed (5 min)",
                            data: interval5MinAverageSpeed.toString()),
                        StatisticWidget(
                            label: "Percentage of Avg Speed (10 min)",
                            data: interval10MinAverageSpeed.toString()),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    Provider.of<Refresher>(context, listen: false).refresher();
                    generatePDF(dataPointList, dataPointList);
                    // logger.i("file created ");
                  },
                  child: Text("PDF report")),
            ],
          ),
        ),
      ),
    );
  }
}
