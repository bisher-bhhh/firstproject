import 'package:bisherproject/core/logical/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

import '../constant.dart';
import '../utils/funcs.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  @lazySingleton
  Dio get dio => Dio()
    ..options.connectTimeout = 10000.duration
    ..options.receiveTimeout = 10000.duration
    ..interceptors.add(_getCustomInterceptor());
  @Named('dioOp')
  @lazySingleton
  Dio get dioOp => Dio()..interceptors.add(_getOpInterceptor());
}

InterceptorsWrapper _getOpInterceptor() => InterceptorsWrapper(
      onRequest: (options, handler) {
        plog(options.uri);
        if (options.data != null) plog(options.data);
        handler.next(options);
      },
      onResponse: (res, handler) {
        plog(res.data);
        handler.next(res);
      },
    );

InterceptorsWrapper _getCustomInterceptor() => InterceptorsWrapper(
      onRequest: (options, handler) async {
        plog(options.uri);
        if (options.data != null) plog(options.data);

        final String? token =
            options.headers[kAuthorization]?.replaceFirst('$kBearer ', '');
        if (token != null && _isExpired(token)) {
          // getIt<AuthCubit>().localLogout();
          // MyApp.appRouter.replaceAll([const LoginRoute()]);
          // function logout
          // @override
          // Future<bool> logout() async {
          //   await _sharedPreferences.clear();
          //   getIt<Dio>().options.headers.remove(kAuthorization);
          //   UserInfo.clear();
          //   return true;
          // }
        }

        handler.next(options);
      },
      onResponse: (res, handler) {
        plog(res.data);
        handler.next(res);
      },
    );

bool _isExpired(String token) {
  final isEx = JwtDecoder.isExpired(token);
  return isEx;
}

// Future<bool> _refreshToken(options) async {
//   final either = await getIt<IAuthRepository>().refreshToken();
//   return either.fold(
//     (l) => false,
//     (r) {
//       options.headers[kAuthorization] = '$kBearer ${UserInfo.user!.token}';
//       return true;
//     },
//   );
// }
