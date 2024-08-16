import 'package:dio/dio.dart';
import 'dart:developer';

class Api {
  final Dio dio = Dio();
  Future<Response> get({
    required String url,
  }) async {
    try {
      log(url);
      Response response = await dio.get(url);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log('DioException: ${e.response!.toString()}');
        return e.response!;
      } else {
        log('DioException without response: ${e.toString()}');
        throw Exception("Request failed: ${e.message}");
      }
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception("Failed to load data: $e");
    }
  }

  Future<Response> post({
    required String url,
    Map<String, dynamic>? jsonData,
    Map<String, dynamic>? headers,
  }) async {
    try {
      log("url $url");
      Response response = await dio.post(
        url,
        data: jsonData,
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log('DioException: ${e.response!.toString()}');
        return e.response!;
      } else {
        log('DioException without response: ${e.toString()}');
        throw Exception("Request failed: ${e.message}");
      }
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception("Failed to load data: $e");
    }
  }

  Future<Response> put({
    required String url,
    required Map<String, dynamic> jsonData,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.put(
        url,
        data: jsonData,
        options: Options(
          headers: headers,
        ),
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        log('DioException: ${e.response!.toString()}');
        return e.response!;
      } else {
        log('DioException without response: ${e.toString()}');
        throw Exception("Request failed: ${e.message}");
      }
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception("Failed to load data: $e");
    }
  }
}
