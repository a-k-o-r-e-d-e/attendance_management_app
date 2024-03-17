import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../routes/app_route.dart';
import '../../../utilities/app_strings.dart';
import '../../saved_info_service/domain/repository/saved_info_repo.dart';
import '../domain/models/api_exception_model.dart';
import '../domain/models/api_response_model.dart';
import '../domain/repository/api_service_repo.dart';

class ApiServiceImpl extends ApiService {
  final Dio _dio;
  final SavedInfoService _savedInfo;
  final AppRouter _navigationService;

  ApiServiceImpl(this._dio, this._savedInfo, this._navigationService);

  @override
  Future<bool> checkTokenExpiry() async {
    // DateTime? tokenExpiryTime = await _savedInfo.getTokenExpirationTime();
    // if (tokenExpiryTime == null) {
    //   print('expired -1');
    //   return true;
    // } else if (DateTime.now().isAfter(tokenExpiryTime)) {
    //   print('expired -2');
    //   return true;
    //   //check if its expiry is close(in 3 minutes time)
    // } else {
    //   print('not expired');
    //   return false;
    // }
    return false;
  }

  @override
  Future<String?> fetchToken() async {
    if (await checkTokenExpiry()) {
      _navigationService.replaceAll([const LoginRoute()]);
      return null;
    } else {
      String? token = (await _savedInfo.getInfo(AppStrings.AUTH_TOKEN_KEY)) as String?;
      return token;
    }
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
          .post(endPoint, data: data)
          .timeout(const Duration(seconds: 120));
      // Handle the response

      return SuccessResponse(response);
    } on DioException catch (error) {
      // Handle the error
      return ErrorResponse(handleError(error));
    }
  }

  @override
  Future<ApiResponseModel<Response, ApiException>> get(
      String endPoint, bool? useToken) async {
    if (useToken == true) {
      String? token = await fetchToken();
      if (token == null) {
        //return ErrorResponse(ApiException("token expired", -2));
      } else {
        _dio.options.headers['Authorization'] = 'Bearer $token';
      }
    }
    try {
      Response response =
          await _dio.get(endPoint).timeout(const Duration(seconds: 120));
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
          .put(endPoint, data: data)
          .timeout(const Duration(seconds: 30));
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
          .delete(endPoint, data: data)
          .timeout(const Duration(seconds: 30));
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
    if (error.response == null) {
      return ApiException("Network request failed", -1);
    }

    try {
      dynamic errorJson = error.response!.data;

      // Check if errorJson is a map
      if (errorJson is Map) {
        List keys = errorJson.keys.toList();

        // Check if there are any keys in the JSON
        if (keys.isNotEmpty) {
          if (errorJson[keys[0]] is List) {
            errorMessage = errorJson[keys[0]][0];
          } else {
            errorMessage = errorJson[keys[0]];
          }
          return ApiException(errorMessage, error.response!.statusCode);
        }
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
