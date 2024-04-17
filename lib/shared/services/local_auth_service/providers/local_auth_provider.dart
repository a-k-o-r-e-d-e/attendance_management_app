import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/local_auth_repo_impl.dart';
import '../domain/repository/local_auth_service_repo.dart';

part 'local_auth_provider.g.dart';

@riverpod
class LocalAuthServiceMethods extends _$LocalAuthServiceMethods {
  @override
  LocalAuthService build() {
    final LocalAuthentication auth = LocalAuthentication();
    return LocalAuthServiceImpl(auth);
  }
// Add methods to mutate the state
}
