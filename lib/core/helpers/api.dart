import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:e_commerce_app/core/services/shared_preferences_singleton.dart';

class Api {
  final Dio dio = Dio();
  String accessToken =
      SharedPreferencesSingleton.getString("accessToken") ?? "";
  String refreshToken =
      SharedPreferencesSingleton.getString("refreshToken") ?? "";

  // Constructor to automatically add the tokens to every request
  Api() {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    dio.options.headers['Cookie'] = "refreshToken=$refreshToken";
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      log(url);
      await Future.delayed(const Duration(seconds: 1));
      Response response = await dio.get(
        url,
        queryParameters: queryParams,
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

  Future<Response> post({
    required String url,
    Map<String, dynamic>? jsonData,
    Map<String, dynamic>? headers,
  }) async {
    try {
      log("url $url");
      await Future.delayed(const Duration(seconds: 1));
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

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? jsonData,
    Map<String, dynamic>? headers,
  }) async {
    try {
      log("url $url");
      await Future.delayed(const Duration(seconds: 1));
      Response response = await dio.delete(
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

  Future<Response> patch({
    required String url,
    Map<String, dynamic>? jsonData,
    Map<String, dynamic>? headers,
  }) async {
    try {
      log("url $url");
      await Future.delayed(const Duration(seconds: 1));
      Response response = await dio.patch(
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
      log("url $url");
      await Future.delayed(const Duration(seconds: 1));
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
