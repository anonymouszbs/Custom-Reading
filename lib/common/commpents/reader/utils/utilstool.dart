import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../untils/log.dart';
//可以下载结束以后拷贝到指定目录 这些复杂的io操作要努力想好操作逻辑 哦吼
initLibs() async {
  // 拷贝 libs
  var docDir = await getTemporaryDirectory();
  var libJs = await rootBundle.load("assets/fxqsj.epub");
  var libJsDest = File("${docDir.path}/assets/epub/test.epub");
  libJsDest.writeAsBytesSync(libJs.buffer.asUint8List());
  Log.d(libJsDest.path, "libjs");
}

Future<File> copyAssetToFile(String assetPath, String filePath) async {
  final data = await rootBundle.load(assetPath);
  final bytes = data.buffer.asUint8List();
  return await File(filePath).writeAsBytes(bytes);
}

// 拷贝demo到沙盒
Future<void> copyDemoToSandBox() async {
  Directory cache = await getTemporaryDirectory();
//  if (exists) return;
  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContent);

  manifestMap.keys
      .where((key) => key.contains('epub/') && !key.contains('.DS_'))
      .forEach((element) async {
    ByteData data = await rootBundle.load(element);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    String dataPath = path.join(cache.path, element);
    File file = File(dataPath);
    await file.create(recursive: true);
    await File(dataPath).writeAsBytes(bytes);
    await initLibs();//把epub文件拷贝到沙盒
  });
}

// 获取拷贝完的HTML路径
Future<String> getIndexHtmlPath() async {
  Directory cache = await getTemporaryDirectory();
  return '${cache.path}/assets/epub/index.html';
}

Future<void> requestPermissions() async {
  var status = await Permission.storage.status;
  if (status.isDenied) {
    // Request permission.
    await Permission.storage.request();
  }
}

startserver() async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
  if (kDebugMode) {
    print('Server listening on port ${server.port}');
  }

  // 设置服务器目录
  final staticFiles = File(await getIndexHtmlPath()).parent.path;
  if (kDebugMode) {
    print(staticFiles);
  }
  server.listen((request) {
    final String requestPath =
        request.uri.path == '/' ? '/index.html' : request.uri.path;
    if (kDebugMode) {
      print(requestPath);
    }
    final File file = File('$staticFiles$requestPath');
    if (file.existsSync()) {
      final ext = file.path.split('.').last.toLowerCase();
      switch (ext) {
        case 'html':
          request.response.headers.contentType = ContentType.html;
          break;
        case 'js':
          request.response.headers.contentType =
              ContentType.parse('text/javascript');
          break;
        case 'css':
          request.response.headers.contentType = ContentType.parse('text/css');
          break;
      }
      file.openRead().pipe(request.response);
    } else {
      request.response.statusCode = HttpStatus.notFound;
      request.response.write('404 Not Found');
      request.response.close();
    }
  });
}
