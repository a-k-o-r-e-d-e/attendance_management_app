import 'package:attendance_management_app/shared/services/dio_service/data/api_service_impl.dart';
import 'package:attendance_management_app/shared/services/saved_info_service/providers/saved_info_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import '../domain/repository/api_service_repo.dart';

part 'api_service_provider.g.dart';

@riverpod
class ApiServiceMethods extends _$ApiServiceMethods {
  late Dio _dioInstance;

  @override
  ApiService build() {
    final savedInfo = ref.watch(savedInfoServiceMethodsProvider);
    _dioInstance = getDio();

    return ApiServiceImpl(_dioInstance, savedInfo);
  }

  Dio getDio() {
    Dio dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30)));

    if (kDebugMode) {
      dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printResponseData: true,
            printRequestHeaders: true,
            printResponseHeaders: true,
            printResponseMessage: true,
          ),
        ),
      );
    }
    return dio;
  }
// Add methods to mutate the state
}
