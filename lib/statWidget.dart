import 'package:flutter/material.dart';
import 'package:technospark/test.dart';

class StatisticWidget extends StatefulWidget {
  StatisticWidget({super.key, required this.label, required this.data});

  final String data;
  final String label;

  @override
  State<StatisticWidget> createState() => _StatisticWidgetState();
}

class _StatisticWidgetState extends State<StatisticWidget> {
  TextEditingController controller = new TextEditingController();
  late Future<dynamic> dataFut;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataFut,
      builder: (context, snapshot) {
        controller.text = widget.data;
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: widget.label,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                enabled: false,
              ),
            ),
          ]);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
