import 'package:dio/dio.dart';

import '../../../../shared/services/dio_service/domain/models/api_exception_model.dart';
import '../../../../shared/services/dio_service/domain/models/api_response_model.dart';
import '../../../../shared/services/dio_service/domain/repository/api_service_repo.dart';

abstract class HomeDataSource {
  Future<ApiResponseModel<Response, ApiException>> fetchUpcomingClass();
}

class HomeRepoDataSource extends HomeDataSource {
  final ApiService api;

  HomeRepoDataSource(this.api);

  @override
  Future<ApiResponseModel<Response, ApiException>> fetchUpcomingClass() {
    return api.get("endPoint", true);
  }
}
