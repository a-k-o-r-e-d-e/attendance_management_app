import 'api_exception_model.dart';

/// Base Result class
/// [S] represents the type of the success value
/// [E] should be [Exception] or a subclass of it
///
sealed class ApiResponseModel<S, E extends ApiException> {
  const ApiResponseModel();
}

final class SuccessResponse<S, E extends ApiException>
    extends ApiResponseModel<S, E> {
  const SuccessResponse(this.value);

  final S value;
  final bool error = false;
}

final class ErrorResponse<S, E extends ApiException>
    extends ApiResponseModel<S, E> {
  const ErrorResponse(this.exception);

  final E exception;
  final bool error = true;
}
