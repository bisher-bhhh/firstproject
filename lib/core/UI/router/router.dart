import 'package:auto_route/auto_route.dart';

import '../../../features/home.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    // AutoRoute(page: LoginPage),
    // AutoRoute(page: SignupPage),
    // AutoRoute(page: ForgetPasswordPage),
    // AutoRoute(page: MainPage),
    // AutoRoute(page: CompanyCodePage),
    // AutoRoute(page: HomePage),
    // AutoRoute(page: CameraPage),
    // AutoRoute(page: SettingsPage),
    // AutoRoute(page: ChangePasswordPage),
    // AutoRoute(page: ChangeEmailPage),
    // AutoRoute(page: VerificationPage),
    // AutoRoute(page: EditProfilePage),
    // AutoRoute(page: ResetSuccessPage),
    // AutoRoute(page: PicturePage),
    // AutoRoute(page: PrivacyPolicyPage),
    // AutoRoute(page: HelpCenterPage),
    // AutoRoute(page: DeleteAccountPage),
    // AutoRoute(page: ChangePhonePage),

  ],
)
class $AppRouter {}
