import 'errors_model.dart';

class Failure {}

class ServerFailure extends Failure {
  final String? message;
  final int? statusCode;
  ServerFailure({
    this.message,
    this.statusCode,
  });
}

class InternetFailure extends Failure {}

class HttpFailure extends Failure {
  final String message;
  final ErrorModel? errorModel;
  HttpFailure(
    this.message, {
    this.errorModel,
  });
}