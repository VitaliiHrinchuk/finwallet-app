import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/cubit/form/account_form_cubit.dart';
import 'package:finwallet_app/app/account/data/account_data_provider.dart';
import 'package:finwallet_app/app/account/data/account_repository.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/usecases/create_account.dart';
import 'package:finwallet_app/app/auth/bloc/auth/auth_bloc.dart';
import 'package:finwallet_app/app/auth/cubit/auth_form_cubit.dart';
import 'package:finwallet_app/app/auth/data/auth_data_provider.dart';
import 'package:finwallet_app/app/auth/data/auth_repository.dart';
import 'package:finwallet_app/app/auth/domain/auth_repository_contract.dart';
import 'package:finwallet_app/app/auth/usecases/check_user.dart';
import 'package:finwallet_app/app/auth/usecases/signin_user.dart';
import 'package:finwallet_app/app/auth/usecases/signout_user.dart';
import 'package:finwallet_app/app/auth/usecases/signup_user.dart';
import 'package:finwallet_app/app/user/bloc/user/user_bloc.dart';
import 'package:finwallet_app/app/user/cubit/user_setup_form_cubit.dart';
import 'package:finwallet_app/app/user/data/user_data_provider.dart';
import 'package:finwallet_app/app/user/data/user_repository.dart';
import 'package:finwallet_app/app/user/domain/user_repository_contract.dart';
import 'package:finwallet_app/app/user/usecases/fetch_user.dart';
import 'package:finwallet_app/app/user/usecases/setup_user.dart';
import 'http_client/http_client.dart';
import 'package:finwallet_app/common/validator.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'contracts.dart';


GetIt di = GetIt.instance;

void setupLocator() {
  // Auth ---------------------
  di.registerFactory(() => AuthBloc(di(), di(), di(), di()));
  di.registerLazySingleton<AuthDataProvider>(() => AuthDataProvider(di()));
  di.registerLazySingleton<AuthRepositoryContract>(() => AuthRepository(di()));
  di.registerFactory(() => AuthFormCubit());

  di.registerLazySingleton<SigninUser>(() => SigninUser(di(), di(), di()));
  di.registerLazySingleton<CheckUser>(() => CheckUser(di(), di()));
  di.registerLazySingleton<SignoutUser>(() => SignoutUser(di()));
  di.registerLazySingleton<SignupUser>(() => SignupUser(di(), di(), di()));

  // User ---------------------
  di.registerFactory(() => UserBloc(di(), di()));
  di.registerLazySingleton<UserDataProvider>(() => UserDataProvider(di()));
  di.registerLazySingleton<UserRepositoryContract>(() => UserRepository(di()));

  di.registerLazySingleton<FetchUser>(() => FetchUser(di()));
  di.registerLazySingleton<SetupUser>(() => SetupUser(di(), di()));
  di.registerFactory<UserSetupFormCubit>(() => UserSetupFormCubit());

  // Account ---------------------
  di.registerFactory(() => AccountBloc(di()));
  di.registerLazySingleton<AccountDataProvider>(() => AccountDataProvider(di()));
  di.registerLazySingleton<AccountRepositoryContract>(() => AccountRepository(di()));

  di.registerLazySingleton<CreateAccount>(() => CreateAccount(di(), di()));

  di.registerFactory<AccountFormCubit>(() => AccountFormCubit());


  di.registerLazySingleton<ValidatorContract>(() => RuleValidator());


}