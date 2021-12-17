import 'package:dio/dio.dart';

class ClientHttp {
  final _dio = Dio();

  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> map,
  ) async {
    final response = await _dio.post(url, data: map);
    return response.data;
  }

  get(
    String url,
    Map<String, dynamic> map,
  ) async {
    final response = await _dio.get(url, queryParameters: map);
    return response.data;
  }
}
