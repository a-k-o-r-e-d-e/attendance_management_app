import '../../../authentication/presentation/providers/states/user_type_state.dart';
import '../models/upcoming_class_model.dart';

abstract class ClassRepository {
  Future<bool> createClass(Map<String, dynamic> userData);
  Future<List<UpcomingClassModel>> fetchClasses(UserType userType);
  Future<bool> deleteClass(String id);
  Future<bool> editClass(String id, Map<String, dynamic> data);
}
