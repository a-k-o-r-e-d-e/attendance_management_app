import '../../../class/domain/models/upcoming_class_model.dart';

abstract class HomeRepo{
  Future<List<UpcomingClassModel>> getUpcomingClass();
}