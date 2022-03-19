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


  di.registerFactory(() => UserBloc(di(), di()));
  di.registerLazySingleton<UserDataProvider>(() => UserDataProvider(di()));
  di.registerLazySingleton<UserRepositoryContract>(() => UserRepository(di()));

  di.registerLazySingleton<FetchUser>(() => FetchUser(di()));
  di.registerLazySingleton<SetupUser>(() => SetupUser(di(), di()));
  di.registerFactory<UserSetupFormCubit>(() => UserSetupFormCubit());
  //
  // // School ---------------------
  //
  // di.registerFactory(() => SchoolBloc(
  //     addSchoolAndInviteAdmin: di(),
  //     deleteSchool: di()
  // ));
  // di.registerFactory(() => SchoolFormCubit());
  // di.registerLazySingleton(() => AddSchoolAndInviteAdmin(di<SchoolRepositoryContract>(),di<InviteRepositoryContract>(), di<ValidatorContract>()));
  // di.registerLazySingleton(() => DeleteSchool(di<SchoolRepositoryContract>(), di<ValidatorContract>()));
  //
  // di.registerLazySingleton<SchoolRepositoryContract>(() => SchoolRepository(di()));
  // di.registerLazySingleton<SchoolDataProvider>(() => SchoolDataProvider());
  //
  // di.registerFactory(() => SchoolListBloc(di<SchoolRepositoryContract>().fetch()));
  //
  // //
  //
  // // - Invite ---------------------
  // // -- data
  // di.registerLazySingleton<InviteDataProvider>(() => InviteDataProvider());
  // di.registerLazySingleton<InviteRepositoryContract>(() => InviteRepository(di()));
  // // -- use case
  // di.registerLazySingleton<ListAdministratorInvites>(() => ListAdministratorInvites(di()));
  // di.registerLazySingleton<SendOrResendAdministratorInvite>(() => SendOrResendAdministratorInvite(di<InviteRepositoryContract>(), di()));
  // di.registerLazySingleton<DeleteAdministratorInvite>(() => DeleteAdministratorInvite(di<InviteRepositoryContract>(), di()));
  // // bloc
  // di.registerFactory(() => AdminInviteListBloc(di<ListAdministratorInvites>().call(NoParams())));
  // di.registerFactory(() => InviteBloc(di<SendOrResendAdministratorInvite>(), di<DeleteAdministratorInvite>()));



  di.registerLazySingleton<ValidatorContract>(() => RuleValidator());


}