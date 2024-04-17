import 'dart:developer';
import 'package:attendance_management_app/features/authentication/presentation/providers/states/user_type_state.dart';
import 'package:attendance_management_app/shared/core/api_endpoints.dart';
import 'package:attendance_management_app/shared/services/dio_service/domain/models/api_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../shared/services/dio_service/domain/models/api_exception_model.dart';
import '../../../../shared/services/dio_service/domain/repository/api_service_repo.dart';
import '../../domain/models/upcoming_class_model.dart';

abstract class ClassDataSource {
  Future<bool> createClass(Map<String, dynamic> data);

  Future<bool> editClass(String id, Map<String, dynamic> data);

  Future<bool> deleteClass(String id);

  Future<List<UpcomingClassModel>> fetchClasses(UserType userType);
}

class ClassRemoteDataSource implements ClassDataSource {
  final ApiService apiService;

  ClassRemoteDataSource(this.apiService);

  @override
  Future<bool> createClass(Map<String, dynamic> data) async {
    try {
      ApiResponseModel<Response, ApiException> response =
          await apiService.post(ApiEndpoints.classes, data, true);

      switch (response) {
        case SuccessResponse(value: final apiData):
          log(apiData.toString());

          return true;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UpcomingClassModel>> fetchClasses(UserType userType) async {
    try {
      ApiResponseModel<Response, ApiException> response = await apiService.get(
          userType == UserType.lecturer
              ? ApiEndpoints.getLecturerClasses
              : ApiEndpoints.getStudentClasses,
          true,
          null);

      switch (response) {
        case SuccessResponse(value: final apiData):
          log(apiData.toString());

          List<UpcomingClassModel> value =
              upcomingClassModelFromJson(apiData.data);
          value.removeWhere((element) =>
              element.status == 'cancelled' || element.status == 'held');
          return value;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteClass(String id) async {
    try {
      ApiResponseModel<Response, ApiException> response =
          await apiService.delete('${ApiEndpoints.classes}/$id', null, true);

      switch (response) {
        case SuccessResponse(value: final apiData):
          log(apiData.toString());

          return true;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> editClass(String id, Map<String, dynamic> data) async {
    try {
      ApiResponseModel<Response, ApiException> response =
          await apiService.put('${ApiEndpoints.classes}/$id', data, true);

      switch (response) {
        case SuccessResponse(value: final apiData):
          log(apiData.toString());

          return true;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }
}
