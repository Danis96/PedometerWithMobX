import 'package:flutter/material.dart';
import 'package:ljubljana/app/state/authentication_store/authentication_store.dart';
import 'package:ljubljana/app/state/onboarding_store/onboarding_store.dart';
import 'package:ljubljana/app/state/pedometer_store/pedometer_store.dart';
import 'package:ljubljana/app/view/change_password/change_password_page.dart';
import 'package:ljubljana/app/view/history_page/history_page.dart';
import 'package:ljubljana/app/view/language/page/language_selection_page.dart';
import 'package:ljubljana/app/view/login/login_page.dart';
import 'package:ljubljana/app/view/onboarding/onboarding_page.dart';
import 'package:ljubljana/app/view/profile/profile_page.dart';
import 'package:ljubljana/app/view/questions/questions_page.dart';
import 'package:ljubljana/app/view/registration/registration_page.dart';
import 'package:ljubljana/app/view/registration/registration_password_page.dart';
import 'package:ljubljana/app/view/walking_type_page/walking_type_page.dart';
import 'package:ljubljana/app/view/welcome_page/welcome_page.dart';
import 'package:ljubljana/routing/routes.dart';

import '../app/utils/navigation_animation.dart';
import '../app/view/forgot_password/forgot_passsword_page.dart';
import '../app/view/forgot_password/forgot_password_code_page.dart';
import '../app/view/forgot_password/forgot_set_password_page.dart';
import '../app/view/homepage/home_screen.dart';
import '../app/view/pedometer_pages/walking_pedometer_page/walking_pedometer_page.dart';
import '../app/view/pedometer_pages/walking_pedometer_test_page/walking_pedometer_test_page.dart';
import '../app/view/questions/list_of_questions/questions_viewpager.dart';
import '../app/view/settings/settings_page.dart';
import '../app/view/splash_page/splash_page.dart';
import '../app/view/walking_agreement/walking_agreement.dart';
import '../app/view/walking_success_page/walking_success_page.dart';
import '../app/view/walking_test_page/walking_test_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return SlideAnimationTween(widget: SplashPage());
      case welcomeScreen:
        return SlideAnimationTween(widget: WelcomePage());
      case registrationScreen:
        return SlideAnimationTween(widget: RegistrationPage());
      case registrationPasswordScreen:
        return SlideAnimationTween(widget: RegistrationPasswordPage(settings.arguments as AuthenticationStore));
      case onBoardingScreen:
        return SlideAnimationTween(widget: OnBoardingPage(settings.arguments as AuthenticationStore));
      case questionScreen:
        return SlideAnimationTween(widget: QuestionsPage(settings.arguments as OnBoardingStore));
      case loginScreen:
        return SlideAnimationTween(widget: LoginPage(settings.arguments as AuthenticationStore));
      case questionsViewPager:
        return SlideAnimationTween(widget: QuestionsViewPager(settings.arguments as OnBoardingStore));
      case forgotPassScreen:
        return SlideAnimationTween(widget: ForgotPasswordPage(settings.arguments as AuthenticationStore));
      case forgotPassCodeScreen:
        return SlideAnimationTween(widget: ForgotPasswordCodePage(settings.arguments as AuthenticationStore));
      case forgotSetPassScreen:
        return SlideAnimationTween(widget: ForgotSetPasswordPage(settings.arguments as AuthenticationStore));
      case homeScreen:
        return SlideAnimationTween(widget: const HomePage());
      case agreementScreen:
        return SlideAnimationTween(widget: WalkingAgreementPage());
      case agreementTestScreen:
        return SlideAnimationTween(widget: const WalkingTestPage());
      case agreementSuccessScreen:
        return SlideAnimationTween(widget: const WalkingSuccessPage());
      case settingsScreen:
        return SlideAnimationTween(widget: const SettingsPage());
      case profileScreen:
        return SlideAnimationTween(widget: const ProfilePage());
      case changePasswordScreen:
        return SlideAnimationTween(widget: ChangePasswordPage());
      case historyScreen:
        return SlideAnimationTween(widget: const HistoryPage());
      case walkingTypeScreen:
        return SlideAnimationTween(widget: const WalkingTypePage());
      case languageRoute:
        return SlideAnimationTween(widget: const LanguageSelectionPage());
      case walkingStepsRoute:
        return SlideAnimationTween(widget: const WalkingPedometerPage());
      case walkingPedometerTestRoute:
        return SlideAnimationTween(widget: WalkingPedometerTestPage(settings.arguments as PedometerStore));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<void>(builder: (_) {
      return Scaffold(appBar: AppBar(title: const Text('Error Route')), body: const Center(child: Text('Error Screen')));
    });
  }
}
