class ApiException implements Exception {
  final String _errorMessage;
  final int? _errorCode;

  /// default value of 0
  ApiException(this._errorMessage, this._errorCode);

  String get error => _errorMessage;

  get errorCode => _errorCode;

  @override
  String toString() {
    return "Api Exception\nError Code::: $errorCode \nError:: $error";
  }
}
