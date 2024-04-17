import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../utilities/app_strings.dart';
import '../../saved_info_service/domain/repository/saved_info_repo.dart';
import '../domain/models/api_exception_model.dart';
import '../domain/models/api_response_model.dart';
import '../domain/repository/api_service_repo.dart';

class ApiServiceImpl extends ApiService {
  final Dio _dio;
  final SavedInfoService _savedInfo;

  ApiServiceImpl(this._dio, this._savedInfo,);

  @override
  Future<String?> fetchToken() async {
    String? token =
        (await _savedInfo.getInfo(AppStrings.AUTH_TOKEN_KEY)) as String?;
    return token;
  }

  @override
  Future<ApiResponseModel<Response, ApiException>> post(
      String endPoint, Map<String, dynamic>? data, bool useToken) async {
    if (useToken) {
      String? token = await fetchToken();
      if (token == null) {
        //_navigationService.pushNamedAndRemoveUntil("/login-view");
        // return ErrorResponse(ApiException("token expired", -2))
      } else {
        _dio.options.headers['Authorization'] = 'Bearer $token';
      }
    }
    try {
      Response response = await _dio
          .post(endPoint, data: data);
      // Handle the response

      return SuccessResponse(response);
    } on DioException catch (error) {
      // Handle the error
      return ErrorResponse(handleError(error));
    }
  }

  @override
  Future<ApiResponseModel<Response, ApiException>> get(
      String endPoint, bool? useToken, Map<String, dynamic>? query) async {
    if (useToken == true) {
      String? token = await fetchToken();
      if (token == null) {
        //return ErrorResponse(ApiException("token expired", -2));
      } else {
        _dio.options.headers['Authorization'] = 'Bearer $token';
      }
    }
    try {
      Response response = await _dio
          .get(endPoint, queryParameters: query);
      // Handle the response

      return SuccessResponse(response);
    } on DioException catch (error) {
      // Handle the error
      if (kDebugMode) {
        print("API call encountered an error!!!!!!");
      }
      return ErrorResponse(handleError(error));
    }
  }

  @override
  Future<ApiResponseModel<Response, ApiException>> put(
      String endPoint, Map<String, dynamic>? data, bool useToken) async {
    if (useToken) {
      String? token = await fetchToken();
      if (token == null) {
        //_navigationService.pushNamedAndRemoveUntil("/login-view");
        // return ErrorResponse(ApiException("token expired", -2))
      } else {
        _dio.options.headers['Authorization'] = 'Bearer $token';
      }
    }
    try {
      Response response = await _dio
          .put(endPoint, data: data);
      // Handle the response

      return SuccessResponse(response);
    } on DioException catch (error) {
      // Handle the error
      return ErrorResponse(handleError(error));
    }
  }

  @override
  Future<ApiResponseModel<Response, ApiException>> delete(
      String endPoint, Map<String, dynamic>? data, bool useToken) async {
    if (useToken) {
      String? token = await fetchToken();
      if (token == null) {
        //_navigationService.pushNamedAndRemoveUntil("/login-view");
        // return ErrorResponse(ApiException("token expired", -2))
      } else {
        _dio.options.headers['Authorization'] = 'Bearer $token';
      }
    }
    try {
      Response response = await _dio
          .delete(endPoint, data: data);
      // Handle the response

      return SuccessResponse(response);
    } on DioException catch (error) {
      // Handle the error
      return ErrorResponse(handleError(error));
    }
  }

  @override
  ApiException handleError(DioException error) {
    String errorMessage;
    // Check if error.response is null
    log(error.response?.data["message"]);
    if (error.response == null) {
      return ApiException("Network request failed", -1);
    }

    try {
      Map errorJson = error.response!.data;
      // Check if errorJson is a map
      List keys = errorJson.keys.toList();

      // Check if there are any keys in the JSON
      if (keys.isNotEmpty) {
        if (errorJson["message"] is List) {
          errorMessage = errorJson["message"][0];
        } else {
          errorMessage = errorJson["message"];
        }
        return ApiException(errorMessage, error.response!.statusCode);
      }
    } catch (e) {
      // Handle JSON parsing error
      return ApiException(
          "Error parsing response JSON", error.response!.statusCode);
    }

    // Fallback for unexpected cases
    return ApiException("Unknown error", error.response!.statusCode);
  }
}
