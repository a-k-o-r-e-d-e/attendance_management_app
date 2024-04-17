import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import '../domain/repository/local_auth_service_repo.dart';

class LocalAuthServiceImpl extends LocalAuthService {
  final LocalAuthentication auth;

  LocalAuthServiceImpl(this.auth);

  @override
  Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  @override
  Future<bool> isDeviceSupported() async {
    return await auth.isDeviceSupported();
  }

  @override
  Future<List<BiometricType>> availableBiometrics() async {
    return await auth.getAvailableBiometrics();
  }

  @override
  Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to mark attendance',
          options: const AuthenticationOptions(biometricOnly: true));
      return didAuthenticate;
      // ···
    } on PlatformException catch (e){
      log(e.toString());
      return false;
    }
  }
}
