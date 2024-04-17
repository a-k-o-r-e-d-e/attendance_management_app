import 'package:attendance_management_app/features/authentication/presentation/providers/states/user_type_state.dart';
import 'package:attendance_management_app/features/class/domain/repository/class_repo.dart';

import '../../domain/models/upcoming_class_model.dart';
import '../data_source/class_remote_data_source.dart';

class ClassRepoImpl extends ClassRepository {
  final ClassDataSource dataSource;

  ClassRepoImpl(this.dataSource);

  @override
  Future<bool> createClass(Map<String, dynamic> userData) {
    return dataSource.createClass(userData);
  }

  @override
  Future<List<UpcomingClassModel>> fetchClasses(UserType userType) {
    return dataSource.fetchClasses(userType);
  }

  @override
  Future<bool> deleteClass(String id) {
    return dataSource.deleteClass(id);
  }

  @override
  Future<bool> editClass(String id, Map<String, dynamic> data) {
    return dataSource.editClass(id, data);

  }
}
