import 'dart:convert';
import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    //print(bytes);

    await file.writeAsBytes(bytes);


    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    final _result = await OpenFilex.open(url);
  }

  static Future<File> base64toPDF(String base64String) async {
    var bytes = base64Decode(base64String.replaceAll('\n', ''));
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(bytes.buffer.asUint8List());

    print("${output.path}/example.pdf");
    await openFile(file);

    return file;
  }
}