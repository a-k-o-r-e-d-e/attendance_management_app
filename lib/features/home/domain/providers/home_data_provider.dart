import 'package:attendance_management_app/features/home/data/data_source/home_remote_data_source.dart';
import 'package:attendance_management_app/shared/services/dio_service/providers/api_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'home_data_provider.g.dart';

@riverpod
class HomeData extends _$HomeData {
  @override
  HomeDataSource build() {
    final api = ref.watch(apiServiceMethodsProvider);

    return HomeRepoDataSource(api);
  }
// Add methods to mutate the state
}
