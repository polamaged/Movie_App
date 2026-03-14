import 'package:flutter/material.dart';
import 'package:movies_app/features/Auth/presentation/views/forgot_password.dart';
import 'package:movies_app/features/Auth/presentation/views/login_view.dart';
import 'package:movies_app/features/Auth/presentation/views/signup_view.dart';
import 'package:movies_app/features/Search/search_view.dart';
import 'package:movies_app/features/home/presentation/home.dart';
import 'package:movies_app/features/home/presentation/widgets/details_movie_card.dart';
import 'package:movies_app/features/onboarding/presentation/on_boarding_view.dart';
import 'package:movies_app/features/onboarding/presentation/widget/first_boarding.dart';
import 'package:movies_app/features/onboarding/presentation/widget/forth_boarding.dart';
import 'package:movies_app/features/onboarding/presentation/widget/last_boarding.dart';
import 'package:movies_app/features/onboarding/presentation/widget/second_boarding.dart';
import 'package:movies_app/features/onboarding/presentation/widget/third_boarding_view.dart';
import 'package:movies_app/features/profile/presentation/profile_view.dart';
import 'package:movies_app/features/profile/presentation/widgets/edit_profile_page.dart';
import 'package:movies_app/features/splash/splash_screen.dart';

abstract class RouteManager {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String detailsMovie = '/details-movie';
  static const String onBoarding = '/onboarding';
  static const String firstBoarding = '/firstBoarding';
  static const String secondBoarding = '/secondBoarding';
  static const String thirdBoarding = '/thirdBoarding';
  static const String fourthBoarding = '/fourthBoarding';
  static const String lastBoarding = '/lastBoarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case firstBoarding:
        return MaterialPageRoute(builder: (_) => const FirstBoarding());
      case secondBoarding:
        return MaterialPageRoute(builder: (_) => const SecondBoarding());
      case thirdBoarding:
        return MaterialPageRoute(builder: (_) => const ThirdBoardingView());
      case fourthBoarding:
        return MaterialPageRoute(builder: (_) => const ForthBoarding());
      case lastBoarding:
        return MaterialPageRoute(builder: (_) => const LastBoarding());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupView());
        case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case home:
        return MaterialPageRoute(builder: (_) => Home());

      case search:
        return MaterialPageRoute(builder: (_) => SearchView());

      case profile:
        return MaterialPageRoute(builder: (_) => ProfileView());

      case editProfile:
        return MaterialPageRoute(builder: (_) => EditProfilePage());

      case detailsMovie:
        final movieId = settings.arguments as int; 

        return MaterialPageRoute(
          builder: (_) => DetailsMovieCard(movieID: movieId),
        );

      default:
        return null;
    }
  }
}
