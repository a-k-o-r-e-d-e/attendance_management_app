import 'package:dio/dio.dart';
import '../../../../shared/services/dio_service/domain/models/api_exception_model.dart';
import '../../../../shared/services/dio_service/domain/models/api_response_model.dart';
import '../../../../shared/services/dio_service/domain/repository/api_service_repo.dart';
import '../../../class/domain/models/upcoming_class_model.dart';

abstract class HomeDataSource {
  Future<ApiResponseModel<Response, ApiException>> fetchUpcomingClass();
}

class HomeRepoDataSource extends HomeDataSource {
  final ApiService api;

  HomeRepoDataSource(this.api);

  @override
  Future<ApiResponseModel<Response, ApiException>> fetchUpcomingClass() {
    /*return api.get("endPoint", true);*/
    return Future.delayed(
        const Duration(seconds: 3),
        () => SuccessResponse(Response(
            data: [UpcomingClassModel()], requestOptions: RequestOptions())));
  }
}
