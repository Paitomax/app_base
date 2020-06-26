import 'package:bloc_test/bloc_test.dart';
import 'package:app_base/src/shared/auth/auth_bloc.dart';
import 'package:app_base/src/shared/auth/auth_event.dart';
import 'package:app_base/src/shared/auth/auth_state.dart';
import 'package:app_base/src/shared/current_datetime/current_date_interface.dart';
import 'package:app_base/src/shared/user/user_repository_interface.dart';
import 'package:app_base/src/sign_in/bloc.dart';
import 'package:app_base/src/sign_in/sign_in_repository_interface.dart';
import 'package:mockito/mockito.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}
class MockSignInBloc extends MockBloc<SignInEvent, SignInState> implements SignInBloc {}

class MockUserRepository extends Mock implements UserRepositoryInterface {}
class MockSignInRepository extends Mock implements SignInRepositoryInterface {}
class MockCurrentDateTime extends Mock implements CurrentDateTimeInterface {}
