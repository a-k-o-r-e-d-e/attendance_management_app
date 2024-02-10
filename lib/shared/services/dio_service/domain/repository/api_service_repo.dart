import 'package:dio/dio.dart';
import '../models/api_exception_model.dart';
import '../models/api_response_model.dart';

abstract class ApiService {
  Future<bool> checkTokenExpiry();

  Future<String?> fetchToken();

  Future<ApiResponseModel<Response, ApiException>> post(
      String endPoint, Map<String, dynamic>? data, bool useToken);

  Future<ApiResponseModel<Response, ApiException>> get(
      String endPoint, bool? useToken);

  Future<ApiResponseModel<Response, ApiException>> put(
      String endPoint, Map<String, dynamic>? data, bool useToken);

  Future<ApiResponseModel<Response, ApiException>> delete(
      String endPoint, Map<String, dynamic>? data, bool useToken);

  ApiException handleError(DioException error);
}
