import 'package:attendance_management_app/features/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:attendance_management_app/features/authentication/data/providers/auth_data_provider.dart';
import 'package:attendance_management_app/features/authentication/data/repository/auth_repo_impl.dart';
import 'package:attendance_management_app/features/authentication/domain/repository/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repo_provider.g.dart';

@riverpod
class AuthRepo extends _$AuthRepo {
  @override
  AuthenticationRepository build() {
    final AuthDataSource dataSource = ref.read(authDataProvider);
    return AuthenticationRepositoryImpl(dataSource);
  }
// Add methods to mutate the state
}
