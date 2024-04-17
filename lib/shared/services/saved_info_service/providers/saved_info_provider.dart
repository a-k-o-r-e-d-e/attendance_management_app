import 'package:attendance_management_app/shared/services/saved_info_service/data/saved_info_impl.dart';
import 'package:attendance_management_app/shared/services/saved_info_service/domain/repository/saved_info_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'saved_info_provider.g.dart';

@riverpod
class SavedInfoServiceMethods extends _$SavedInfoServiceMethods {
  @override
  SavedInfoService build() {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    return SavedInfoImpl(secureStorage);
  }
// Add methods to mutate the state
}
