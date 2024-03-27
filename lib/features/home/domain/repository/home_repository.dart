import '../model/upcoming_class_model.dart';

abstract class HomeRepo{
  Future<List<UpcomingClassModel>> getUpcomingClass();
}