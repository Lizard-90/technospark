import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:technospark/test.dart';
import 'dart:io';
import 'package:flutter/material.dart';

var logger = Logger();
PdfDocument document = PdfDocument();

Future<void> generatePDF(
    List<DataPoint> intervalData5Min, List<DataPoint> intervalData10Min) async {
  //Create a new PDF document
  PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;
  final PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 20);
  // final PdfSolidBrush brush = PdfSolidBrush(PdfColor(0, 0, 0));
  final double lineHeight = font.height + 20;
  double y = 50;

  //Add a new page and draw text
  graphics.drawString('TotalAverageSpeed: $totalAverageSpeed', font,
      bounds: Rect.fromLTWH(0, y, 500, lineHeight));
  y += lineHeight;
  graphics.drawString(
      'Interval5MinAverageSpeed: ${interval5MinAverageSpeed.toStringAsFixed(2)}',
      font,
      bounds: Rect.fromLTWH(0, y, 500, lineHeight));
  y += lineHeight;

  graphics.drawString(
      'Interval10MinAverageSpeed: ${interval10MinAverageSpeed.toStringAsFixed(2)}',
      font,
      bounds: Rect.fromLTWH(0, y, 500, lineHeight));
  y += lineHeight;

  graphics.drawString(
      'Percentage of Avg Speed (5 min): ${(interval5MinAverageSpeed / totalAverageSpeed * 100).toStringAsFixed(2)}%',
      font,
      bounds: Rect.fromLTWH(0, y, 500, lineHeight));
  y += lineHeight;

  graphics.drawString(
      'Percentage of Avg Speed (10 min): ${(interval10MinAverageSpeed / totalAverageSpeed * 100).toStringAsFixed(2)}%',
      font,
      bounds: Rect.fromLTWH(0, y, 500, lineHeight));
  y += lineHeight;

  //Save the document
  List<int> bytes = await document.save();

  //Dispose the document
  document.dispose();
  //Get external storage directory
  final directory = await getApplicationSupportDirectory();

//Get directory path
  final path = directory.path;

//Create an empty file to write PDF data
  File file = File('$path/Output.pdf');

//Write PDF data
  await file.writeAsBytes(bytes, flush: true);

//Open the PDF document in mobile
  OpenFile.open('$path/Output.pdf');
}
