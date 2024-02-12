import 'dart:developer';

import 'package:attendance_management_app/features/home/domain/model/upcoming_class_model.dart';
import 'package:attendance_management_app/features/home/domain/repository/home_repository.dart';
import 'package:dio/dio.dart';

import '../../../../shared/services/dio_service/domain/models/api_exception_model.dart';
import '../../../../shared/services/dio_service/domain/models/api_response_model.dart';
import '../data_source/home_remote_data_source.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeDataSource dataSource;

  HomeRepoImpl(this.dataSource);

  @override
  Future<List<UpcomingClassModel>> getUpcomingClass() async {
    ApiResponseModel<Response, ApiException> response =
        await dataSource.fetchUpcomingClass();
    log(response.toString());
    switch (response) {
      case SuccessResponse(value: final upcomingClassModel):
        print(upcomingClassModel.data);
        return upcomingClassModel.data;
      case ErrorResponse(exception: ApiException error):
        throw error;
    }
  }
}
