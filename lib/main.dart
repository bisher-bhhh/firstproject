import 'package:bisherproject/injectable/injecter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/UI/router/router.gr.dart';
import 'core/UI/styles/colors.dart';
import 'core/logical/network/internet_info.dart';
import 'core/logical/utils/lang.dart';
part 'main_config.dart';

void main() async

{

   final wb = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: wb);
  InternetInfo.initState;
  await Future.wait([
    configureDependencies(),
    EasyLocalization.ensureInitialized(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]),
  ]);
  runApp( EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      useOnlyLangCode: true,
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('en'),
      child: const MyApp(),
    ));
  
  
  }

class MyApp extends StatefulWidget {
  const MyApp({super.key});
 static final _navKey = GlobalKey<NavigatorState>();
  static final AppRouter appRouter = AppRouter(_navKey);
  static BuildContext? get globalContext => appRouter.navigatorKey.currentContext;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
          title: 'task prove',
          scrollBehavior: MyCustomScrollBehavior(),
          routerDelegate: MyApp.appRouter.delegate(),
          routeInformationParser: MyApp.appRouter.defaultRouteParser(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(colorSchemeSeed: MyColors.primary, fontFamily: 'Tajawal'
              // textTheme: getTheme(context),
              ),
        );
  }
}