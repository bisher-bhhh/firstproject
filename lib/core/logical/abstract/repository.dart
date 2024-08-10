import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../constant.dart';
import '../errors/errors_model.dart';
import '../errors/failures.dart';
import '../network/internet_info.dart';
import '../utils/funcs.dart';
import '../utils/lang.dart';

Future<Either<Failure, T>> sendRequest<T>(
  Future<T> Function() call, {
  Function(T)? cacheCall,
}) async {
  if (InternetInfo.isConnect) {
    try {
      final T result = await call();
      await cacheCall?.call(result);
      return Right(result);
    } on DioException catch (e) {
      eplog(e);
      eplog(e.response?.data);
      if (e.type.name.contains('Timeout') || (e.response?.statusCode ?? 0) >= 500) {
        return Left(ServerFailure());
      } else if (e.response?.statusCode == 401 && e.requestOptions.headers[kAuthorization] != null) {
        // await MyApp.globalContext?.read<AuthCubit>().logout(UserInfo.user!.refreshToken!);
        return Right(await call());
      } else if (e.response?.statusCode == 403 || e.response?.statusCode == 404) {
        return Left(ServerFailure(statusCode: e.response!.statusCode));
      } else if (e.response?.statusCode == 400) {
        if (!Lang.isEn) return Left(HttpFailure('there_is_an_error_in_the_input'));
        try {
          Map error = e.response!.data['meta']['message'] ??
              //show the first error message
              {
                "": ['there_is_an_error_in_the_input']
              };
          return Left(HttpFailure(error.values.first[0]));
        } catch (e) {}
        return Left(HttpFailure('there_is_an_error_in_the_input'));
      }
      ErrorModel? errorModel;
      if (e.response?.data != null && e.response?.data is Map) {
        try {
          errorModel = ErrorModel.fromJson(e.response!.data);
        } on Exception catch (_) {}
      }
      return Left(HttpFailure(
        errorModel != null ? errorModel.message ?? kServerErrorMessage : kSomethingWentWrong,
        errorModel: errorModel,
      ));
    }
  } else
    return Left(InternetFailure());
}