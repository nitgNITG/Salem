import 'dart:io';
import 'package:al_mariey/app/modules/base/base_controller.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class OpenPdfController extends BaseController {
  File? file;

  Future<File> downloadFile(String url, String filename) async {
    final response = await http.get(Uri.parse(url));
    final directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/$filename');

    await file!.writeAsBytes(response.bodyBytes);

    return file!;
  }
}
