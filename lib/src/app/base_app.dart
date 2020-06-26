import 'package:app_base/src/app/app_routes.dart';
import 'package:app_base/src/home/home_screen.dart';
import 'package:app_base/src/shared/auth/auth_bloc.dart';
import 'package:app_base/src/shared/auth/auth_event.dart';
import 'package:app_base/src/shared/auth/auth_state.dart';
import 'package:app_base/src/shared/consts/app_keys.dart';
import 'package:app_base/src/shared/current_datetime/current_date.dart';
import 'package:app_base/src/shared/current_datetime/current_date_interface.dart';
import 'package:app_base/src/shared/theme/app_base_theme.dart';
import 'package:app_base/src/shared/user/user_repository.dart';
import 'package:app_base/src/shared/user/user_repository_interface.dart';
import 'package:app_base/src/sign_in/sign_in_bloc.dart';
import 'package:app_base/src/sign_in/sign_in_data_provider.dart';
import 'package:app_base/src/sign_in/sign_in_repository.dart';
import 'package:app_base/src/sign_in/sign_in_repository_interface.dart';
import 'package:app_base/src/sign_in/sign_in_screen.dart';
import 'package:app_base/src/splash/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseAppGlobalProvider extends StatelessWidget {
  final Widget child;

  const BaseAppGlobalProvider({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepositoryInterface>(
      create: (BuildContext context) => UserRepository(),
      child: BlocProvider<AuthBloc>(
        create: (BuildContext context) => AuthBloc(
          RepositoryProvider.of<UserRepositoryInterface>(context),
        ),
        child: child,
      ),
    );
  }
}

class BaseApp extends StatefulWidget {
  const BaseApp({Key key}) : super(key: key);

  @override
  _BaseAppState createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  void initState() {
    context.bloc<AuthBloc>().add(AuthAppInitiated());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppBaseTheme();
    final materialApp = MaterialApp(
        title: AppKeys.appName,
        builder: DevicePreview.appBuilder,
        home: _buildHome(),
        theme: theme.themeData,
        routes: AppRoutes.routes);

    return _providers(
      child: Center(child: materialApp),
    );
  }

  Widget _buildHome() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        Widget newWidget;

        if (state is AuthInitial) {
          newWidget = SplashScreen();
        } else if (state is AuthUnauthenticated) {
          newWidget = SignInScreen();
        } else if (state is AuthAuthenticated) {
          newWidget = HomeScreen();
        } else {
          newWidget = CircularProgressIndicator();
        }

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: newWidget,
        );
      },
    );
  }

  MultiRepositoryProvider _providers({Widget child}) {
    final Dio dio = Dio();

    final SignInDataProvider signInDataProvider = SignInDataProvider();
    final CurrentDateTimeInterface currentDateTime = CurrentDateTime();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SignInRepositoryInterface>(
          create: (context) => SignInRepository(signInDataProvider),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignInBloc(
              RepositoryProvider.of<SignInRepositoryInterface>(context),
              BlocProvider.of<AuthBloc>(context),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
