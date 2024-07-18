import 'package:dio/dio.dart';
import 'dart:developer';

class Api {
  final Dio dio = Dio();

  Future<List<dynamic>> get({required String url}) async {
    try {
      Response response = await dio.get(url);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return response.data;
      } else {
        throw Exception(
            "there was an error in status code ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log('Error response: ${e.response?.data}');
        log('Error status code: ${e.response?.statusCode}');
      } else {
        log('Error message: ${e.message}');
      }
      throw Exception("Failed to load data: ${e.message}");
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception("Failed to load data: $e");
    }
  }

  Future<void> post({
    required String url,
    required Map<String, dynamic> jsonData,
    Map<String, dynamic> ?headers,
  }) async {
    try {
      Response response = await dio.post(
        url,
        data: jsonData,
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      } else {
        throw Exception(
            "there was an error in status code ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log('Error response: ${e.response?.data}');
        log('Error status code: ${e.response?.statusCode}');
      } else {
        log('Error message: ${e.message}');
      }
      throw Exception("Failed to load data: ${e.message}");
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception("Failed to load data: $e");
    }
  }

  Future<void> put({
    required String url,
    required Map<String, dynamic> jsonData,
    Map<String, dynamic> ?headers,
  }) async {
    try {
      Response response = await dio.put(
        url,
        data: jsonData,
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      } else {
        throw Exception(
            "there was an error in status code ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log('Error response: ${e.response?.data}');
        log('Error status code: ${e.response?.statusCode}');
      } else {
        log('Error message: ${e.message}');
      }
      throw Exception("Failed to load data: ${e.message}");
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception("Failed to load data: $e");
    }
  }
}
