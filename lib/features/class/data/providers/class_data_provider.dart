import 'package:attendance_management_app/shared/services/dio_service/providers/api_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/services/dio_service/domain/repository/api_service_repo.dart';
import '../data_source/class_remote_data_source.dart';

part 'class_data_provider.g.dart';

@riverpod
class ClassData extends _$ClassData {
  @override
  ClassDataSource build() {
    final ApiService apiService = ref.read(apiServiceMethodsProvider);
    return ClassRemoteDataSource(apiService);
  }
// Add methods to mutate the state
}
