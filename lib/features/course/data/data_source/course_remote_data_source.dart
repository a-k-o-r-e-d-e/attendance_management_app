import 'dart:developer';

import 'package:attendance_management_app/features/authentication/domain/models/user_model.dart';
import 'package:attendance_management_app/shared/core/api_endpoints.dart';
import 'package:attendance_management_app/shared/services/dio_service/domain/models/api_response_model.dart';
import 'package:dio/dio.dart';

import '../../../../shared/services/dio_service/domain/models/api_exception_model.dart';
import '../../../../shared/services/dio_service/domain/repository/api_service_repo.dart';
import '../../../../shared/services/saved_info_service/domain/repository/saved_info_repo.dart';
import '../../domain/models/course_model.dart';

abstract class CourseDataSource {
  Future<List<Course>> fetchAllCourse();

  Future<Course> createCourse(Map<String, dynamic> data);

  Future<List<Profile>> getEnrolledStudents(String courseId);

  Future<bool> enrollCourse(String courseId);
}

class CourseRemoteDataSource implements CourseDataSource {
  final ApiService apiService;
  final SavedInfoService savedInfoService;

  CourseRemoteDataSource(this.apiService, this.savedInfoService);

  @override
  Future<List<Course>> fetchAllCourse() async {
    try {
      ApiResponseModel<Response, ApiException> response =
          await apiService.get(ApiEndpoints.getCourses, true, null);

      switch (response) {
        case SuccessResponse(value: final apiData):
          List<Course> courseList = apiData.data
              .map<Course>((courseData) => Course.fromJson(courseData))
              .toList();
          //save the users detail
          //await _savedInfo.saveUserDetails(userModel);
          log(courseList.toString());

          return courseList;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Course> createCourse(Map<String, dynamic> data) async {
    try {
      ApiResponseModel<Response, ApiException> response =
          await apiService.post(ApiEndpoints.getCourses, data, true);

      switch (response) {
        case SuccessResponse(value: final apiData):
          Course course = Course.fromJson(apiData.data);
          //save the users detail
          //await _savedInfo.saveUserDetails(userModel);
          log(course.toString());

          return course;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Profile>> getEnrolledStudents(String courseId) async {
    try {
      ApiResponseModel<Response, ApiException> response = await apiService.get(
          "${ApiEndpoints.getCourses}/$courseId/students", true, null);

      switch (response) {
        case SuccessResponse(value: final apiData):
          List<Profile> students = apiData.data
              .map<Profile>((courseData) => Profile.fromJson(courseData))
              .toList();
          //save the users detail
          //await _savedInfo.saveUserDetails(userModel);
          log(students.toString());

          return students;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> enrollCourse(String courseId) async{
    try {
      ApiResponseModel<Response, ApiException> response = await apiService.get(
          "${ApiEndpoints.getCourses}/$courseId/enroll", true, null);

      switch (response) {
        case SuccessResponse(value: final apiData):
          //save the users detail
          //await _savedInfo.saveUserDetails(userModel);
          log(apiData.data.toString());

          return true;
        case ErrorResponse(exception: ApiException error):
          throw ErrorResponse(error);
      }
    } catch (e) {
      rethrow;
    }
  }
}
