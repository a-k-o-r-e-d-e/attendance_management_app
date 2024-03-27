import 'package:attendance_management_app/shared/services/dio_service/providers/api_service_provider.dart';
import 'package:attendance_management_app/shared/services/saved_info_service/domain/repository/saved_info_repo.dart';
import 'package:attendance_management_app/shared/services/saved_info_service/providers/saved_info_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/services/dio_service/domain/repository/api_service_repo.dart';
import '../data_source/profile_remote_data_source.dart';

part 'profile_data_provider.g.dart';

@riverpod
class ProfileData extends _$ProfileData {
  @override
  ProfileDataSource build() {
    final ApiService apiService = ref.read(apiServiceMethodsProvider);
    final SavedInfoService savedService =
        ref.read(savedInfoServiceMethodsProvider);
    return ProfileRemoteDataSource(apiService, savedService);
  }
// Add methods to mutate the state
}
