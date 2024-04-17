import 'package:attendance_management_app/shared/services/location_service/data/location_repo_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/repository/location_service_repo.dart';

part 'location_provider.g.dart';

@riverpod
class LocationServiceMethods extends _$LocationServiceMethods {
  @override
  LocationService build() {
    return LocationServiceImpl();
  }
// Add methods to mutate the state
}
