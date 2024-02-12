import '../../../../shared/services/dio_service/domain/models/api_exception_model.dart';
import '../../../../shared/services/dio_service/domain/models/api_response_model.dart';
import '../model/upcoming_class_model.dart';

abstract class HomeRepo{
  Future<List<UpcomingClassModel>> getUpcomingClass();
}