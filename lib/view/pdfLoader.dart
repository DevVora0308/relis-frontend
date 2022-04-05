import 'dart:async';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class PDFLoader {
  static var dio = Dio();

  static Future<File> loadAsset(String path) async {
    print("\t... in loadAsset");
    final data = await rootBundle.load(path);
    print("\t... loaded data");
    print(data.toString());
    final bytes = data.buffer.asUint8List();
    print("\t... loaded bytes");
    return _storeFile(path, bytes);
  }

  static Future<File> loadNetwork(String url) async {
    print("Uri.parse(url) is: ${Uri.parse(url)}");
    var response, bytes;
    try {
       response = await http.get(
         Uri.parse(url)
       );
       print(response.statusCode);
       print(response.body);
       print("response is: $response");
       // bytes = response.bodyBytes;
    } catch(e) {
      print("E: $e");
    }

    print("bytes is: $bytes");
    print("response: ${response}");
    print("response.statusCode: ${response.statusCode}");
    print("response.body: ${response.body}");
    bytes = [202,100,10];
    print("bytes is: $bytes");
    return _storeFile(url, bytes);
  }

  static Future<File> loadNetworkDio (String url) async {
    print("\t In loadNetwork");
    print("url: $url");
    Response response = await dio.get(
      url,
      onReceiveProgress: (received, total) {
        print("received: $received, total: $total");
      },
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return status!<500;
        }),
    );
    print(response.headers);
    print("\t got Response");
    print("\t response: ${response}");
    final bytes = response.data; // response.bodyBytes
    print("\t bytes: ${bytes}");
    final byteList = Uint8List.fromList(response.data);
    print("\t byteList: ${byteList}");
    final byteData = ByteData.view(byteList.buffer);
    print("\t byteData: ${byteData}");

    return _storeFile(url, bytes);
  }

  static Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return null;
    String path = result.paths.first.toString();
    return File(path);   // return File(result.paths.first);
  }

  // static Future<File> loadFirebase(String url) async {
  //   try {
  //     final refPDF = FirebaseStorage.instance.ref().child(url);
  //     final bytes = await refPDF.getData();
  //
  //     return _storeFile(url, bytes);
  //   } catch (e) {
  //     return null;
  //   }
  // }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    print("\t... in _storeFile");
    print("Reached here...");
    print(bytes.length);
    var contents = String.fromCharCodes(bytes);
    print("Contents are: ");
    print(contents.length);
    print(contents);
    // print(contents);
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

}