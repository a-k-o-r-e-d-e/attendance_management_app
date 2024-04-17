import 'dart:developer';
import 'package:attendance_management_app/shared/models/user_model.dart';
import 'package:attendance_management_app/shared/core/api_endpoints.dart';
import 'package:attendance_management_app/shared/services/dio_service/domain/models/api_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../shared/services/dio_service/domain/models/api_exception_model.dart';
import '../../../../shared/services/dio_service/domain/repository/api_service_repo.dart';
import '../../../../shared/services/saved_info_service/domain/repository/saved_info_repo.dart';
import '../../../authentication/presentation/providers/states/user_type_state.dart';

abstract class ProfileDataSource {
  Future<Profile> fetchMyProfile(UserType userType);

  Future<Profile> updateProfile(
      UserType userType, Map<String, dynamic> userData);

  Future<Profile> fetchProfileById(UserType userType, String id);
}

class ProfileRemoteDataSource implements ProfileDataSource {
  final ApiService apiService;
  final SavedInfoService savedInfoService;

  ProfileRemoteDataSource(this.apiService, this.savedInfoService);

  @override
  Future<Profile> fetchMyProfile(UserType userType) async {
    try {
      ApiResponseModel<Response, ApiException> response = await apiService.get(
          userType == UserType.student
              ? ApiEndpoints.getStudentProfile
              : ApiEndpoints.getLecturerProfile,
          true,
          null);

      switch (response) {
        case SuccessResponse(value: final apiData):
          Profile userModel = Profile.fromJson(apiData.data);

          log(apiData.data.toString());

          return userModel;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Profile> fetchProfileById(UserType userType, String id) async {
    try {
      ApiResponseModel<Response, ApiException> response = await apiService.get(
          userType == UserType.student
              ? ApiEndpoints.getStudentProfileById
              : ApiEndpoints.getLecturerProfileById,
          true,
          {"id": id});
      switch (response) {
        case SuccessResponse(value: final apiData):
          Profile userModel = Profile.fromJson(apiData.data);

          //save the users detail

          log(apiData.data.toString());

          return userModel;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Profile> updateProfile(
      UserType userType, Map<String, dynamic> userData) async {
    try {
      ApiResponseModel<Response, ApiException> response = await apiService.put(
          userType == UserType.student
              ? ApiEndpoints.getStudentProfile
              : ApiEndpoints.getLecturerProfile,
          userData,
          true);

      switch (response) {
        case SuccessResponse(value: final apiData):
          Profile userModel = Profile.fromJson(apiData.data);

          log(apiData.data.toString());

          return userModel;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }
}
