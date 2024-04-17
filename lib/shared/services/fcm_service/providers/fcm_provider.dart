import 'package:attendance_management_app/shared/services/saved_info_service/providers/saved_info_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/fcm_repo_impl.dart';
import '../domain/repository/fcm_service_repo.dart';

part 'fcm_provider.g.dart';

@riverpod
class FcmServiceMethods extends _$FcmServiceMethods {
  @override
  FcmService build() {
    final instance = FirebaseMessaging.instance;
    final savedInfo = ref.read(savedInfoServiceMethodsProvider);

    return FcmServiceImpl(instance, savedInfo);
  }
// Add methods to mutate the state
}
