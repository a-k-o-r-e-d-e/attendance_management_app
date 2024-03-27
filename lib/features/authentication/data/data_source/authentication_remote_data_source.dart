import 'dart:developer';

import 'package:attendance_management_app/features/authentication/domain/models/user_model.dart';
import 'package:attendance_management_app/features/authentication/presentation/providers/states/user_type_state.dart';
import 'package:attendance_management_app/shared/core/api_endpoints.dart';
import 'package:attendance_management_app/shared/services/dio_service/domain/models/api_response_model.dart';
import 'package:attendance_management_app/shared/utilities/app_strings.dart';
import 'package:dio/dio.dart';

import '../../../../shared/services/dio_service/domain/models/api_exception_model.dart';
import '../../../../shared/services/dio_service/domain/repository/api_service_repo.dart';
import '../../../../shared/services/saved_info_service/domain/repository/saved_info_repo.dart';

abstract class AuthDataSource {
  Future<UserAccount> createAccount(
      {required Map<String, dynamic> userData, required UserType userType});

  Future<UserAccount> login({required Map<String, dynamic> userData});

  Future<UserAccount> authenticate();
}

class AuthRemoteDataSource implements AuthDataSource {
  final ApiService apiService;
  final SavedInfoService savedInfoService;

  AuthRemoteDataSource(this.apiService, this.savedInfoService);

  @override
  Future<UserAccount> createAccount(
      {required Map<String, dynamic> userData,
      required UserType userType}) async {
    try {
      ApiResponseModel<Response, ApiException> response = await apiService.post(
          userType == UserType.lecturer
              ? ApiEndpoints.registerLecturer
              : ApiEndpoints.registerStudent,
          userData,
          false);

      switch (response) {
        case SuccessResponse(value: final apiUserModel):
          UserAccount userModel = UserAccount.fromJson(apiUserModel.data);
          //save the users detail
          //await _savedInfo.saveUserDetails(userModel);
          log(userModel.toString());

          return userModel;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserAccount> login({required Map<String, dynamic> userData}) async {
    try {
      ApiResponseModel<Response, ApiException> response =
          await apiService.post(ApiEndpoints.login, userData, false);

      switch (response) {
        case SuccessResponse(value: final apiUserModel):
          UserAccount userModel = UserAccount.fromJson(apiUserModel.data);

          //save the users detail

          await savedInfoService.saveInfo(AppStrings.USER_JSON_KEY, userModel);
          log("user saved!");
          await savedInfoService.saveInfo(
              AppStrings.AUTH_TOKEN_KEY, userModel.accessToken!);
          log("token saved!");

          log(apiUserModel.data.toString());

          return userModel;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserAccount> authenticate() async {
    try {
      ApiResponseModel<Response, ApiException> response =
          await apiService.get(ApiEndpoints.authenticate, true, null);

      switch (response) {
        case SuccessResponse(value: final apiUserModel):
          UserAccount userModel = UserAccount.fromJson(apiUserModel.data);

          //save the users detail

          await savedInfoService.saveInfo(AppStrings.USER_JSON_KEY, userModel);
          await savedInfoService.saveInfo(
              AppStrings.AUTH_TOKEN_KEY, userModel.accessToken!);

          log(apiUserModel.data.toString());

          return userModel;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }
}
