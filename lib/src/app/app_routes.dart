import 'package:app_base/src/home/home_screen.dart';
import 'package:app_base/src/sign_in/sign_in_screen.dart';
import 'package:app_base/src/splash/splash_screen.dart';

class AppRoutes {
  static final routes = {
    SplashScreen.routeName: (context) => SplashScreen(),
    SignInScreen.routeName: (context) => SignInScreen(),
    HomeScreen.routeName: (context) => HomeScreen(),
  };
}
