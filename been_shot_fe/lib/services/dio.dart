import 'dart:io';

import 'package:dio/dio.dart';

class DioClient {
  factory DioClient() => _instance;
  // 通信ツール（DioClient)を使いたいと呼び出す窓口
  // あらかじめ作っておいた唯一のツールをそのまま渡す（_instance）

  DioClient._createSingleton() {
    unauthDio = _createDio();
  }
  // 「_」つける＝＞プライベート化

  static final DioClient _instance = DioClient._createSingleton();

  late final Dio unauthDio;

  Dio _createDio() {
    return Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
        validateStatus: (status) {
          return status != null && status < 400;
        },
      ),
    );
  }
}
