import 'package:attendance_management_app/features/home/data/repository/home_repo_impl.dart';
import 'package:attendance_management_app/features/home/domain/providers/home_data_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/home_repository.dart';

part 'home_repo_provider.g.dart';

@riverpod
class HomeRepository extends _$HomeRepository {
  @override
  HomeRepo build() {
    final dataSource = ref.watch(homeDataProvider);

    return HomeRepoImpl(dataSource);
  }
// Add methods to mutate the state
}
