
import 'package:local_auth/local_auth.dart';

abstract class LocalAuthService {
  Future<bool> canCheckBiometrics();
  Future<bool> isDeviceSupported();
  Future<List<BiometricType>>  availableBiometrics();
  Future<bool>  authenticate();
}
