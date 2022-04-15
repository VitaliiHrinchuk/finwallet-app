import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/cubit/analytics/analytics_cubit.dart';
import 'package:finwallet_app/app/account/cubit/form/account_form_cubit.dart';
import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/data/account_data_provider.dart';
import 'package:finwallet_app/app/account/data/account_repository.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/date_node_model.dart';
import 'package:finwallet_app/app/account/domain/analytics_type.dart';
import 'package:finwallet_app/app/account/usecases/create_account.dart';
import 'package:finwallet_app/app/account/usecases/fetch_summary_by_category.dart';
import 'package:finwallet_app/app/account/usecases/fetch_summary_by_date.dart';
import 'package:finwallet_app/app/account/usecases/list_account.dart';
import 'package:finwallet_app/app/account/usecases/remove_account.dart';
import 'package:finwallet_app/app/account/usecases/update_account.dart';
import 'package:finwallet_app/app/auth/bloc/auth/auth_bloc.dart';
import 'package:finwallet_app/app/auth/cubit/auth_form_cubit.dart';
import 'package:finwallet_app/app/auth/data/auth_data_provider.dart';
import 'package:finwallet_app/app/auth/data/auth_repository.dart';
import 'package:finwallet_app/app/auth/domain/auth_repository_contract.dart';
import 'package:finwallet_app/app/auth/usecases/check_user.dart';
import 'package:finwallet_app/app/auth/usecases/signin_user.dart';
import 'package:finwallet_app/app/auth/usecases/signout_user.dart';
import 'package:finwallet_app/app/auth/usecases/signup_user.dart';
import 'package:finwallet_app/app/category/cubit/list/category_list_cubit.dart';
import 'package:finwallet_app/app/category/data/category_data_provider.dart';
import 'package:finwallet_app/app/category/data/category_repository.dart';
import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import 'package:finwallet_app/app/category/usecases/list_category.dart';
import 'package:finwallet_app/app/tag/cubit/list/tag_list_cubit.dart';
import 'package:finwallet_app/app/tag/data/tag_data_provider.dart';
import 'package:finwallet_app/app/tag/data/tag_repostitory.dart';
import 'package:finwallet_app/app/tag/domain/tag_repository_contract.dart';
import 'package:finwallet_app/app/tag/usecases/query_tags.dart';
import 'package:finwallet_app/app/transaction/cubit/form/transaction_form_cubit.dart';
import 'package:finwallet_app/app/transaction/cubit/list/transactions_list_cubit.dart';
import 'package:finwallet_app/app/transaction/cubit/math_pad/math_pad_cubit.dart';
import 'package:finwallet_app/app/transaction/cubit/transaction/transaction_cubit.dart';
import 'package:finwallet_app/app/transaction/data/transaction_data_provider.dart';
import 'package:finwallet_app/app/transaction/data/transaction_repostitory.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_repository_contract.dart';
import 'package:finwallet_app/app/transaction/usecases/create_transaction.dart';
import 'package:finwallet_app/app/transaction/usecases/query_transactions.dart';
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
  di.registerFactory(() => AccountBloc(di(), di(), di(), di()));
  di.registerLazySingleton<AccountDataProvider>(() => AccountDataProvider(di()));
  di.registerLazySingleton<AccountRepositoryContract>(() => AccountRepository(di()));

  di.registerLazySingleton<CreateAccount>(() => CreateAccount(di(), di()));
  di.registerLazySingleton<UpdateAccount>(() => UpdateAccount(di(), di()));
  di.registerLazySingleton<RemoveAccount>(() => RemoveAccount(di(), di()));
  di.registerLazySingleton<ListAccount>(() => ListAccount(di()));
  di.registerLazySingleton<FetchSummaryByCategory>(() => FetchSummaryByCategory(di()));
  di.registerLazySingleton<FetchSummaryByDate>(() => FetchSummaryByDate(di()));

  di.registerFactory<AccountFormCubit>(() => AccountFormCubit());
  di.registerFactory<AccountsListCubit>(() => AccountsListCubit(di()));
  di.registerFactory<AnalyticsCubit<CategoryNodeModel>>(() => AnalyticsCubit<CategoryNodeModel>(AnalyticsType.category, di(), di()));
  di.registerFactory<AnalyticsCubit<DateNodeModel>>(() => AnalyticsCubit<DateNodeModel>(AnalyticsType.date, di(), di()));

  // Transaction ----------
  di.registerLazySingleton<TransactionDataProvider>(() => TransactionDataProvider(di()));
  di.registerLazySingleton<TransactionRepositoryContract>(() => TransactionRepository(di()));
  di.registerLazySingleton<QueryTransactions>(() => QueryTransactions(di()));
  di.registerLazySingleton<CreateTransaction>(() => CreateTransaction(di()));

  di.registerFactory<TransactionsListCubit>(() => TransactionsListCubit(di()));
  di.registerFactory<MathPadCubit>(() => MathPadCubit());
  di.registerFactory<TransactionFormCubit>(() => TransactionFormCubit());
  di.registerFactory<TransactionCubit>(() => TransactionCubit(di()));

  di.registerLazySingleton<ValidatorContract>(() => RuleValidator());

  // Category ---------------------
  di.registerLazySingleton<CategoryDataProvider>(() => CategoryDataProvider(di()));
  di.registerLazySingleton<CategoryRepositoryContract>(() => CategoryRepository(di()));

  di.registerLazySingleton<ListCategory>(() => ListCategory(di()));

  di.registerFactory<CategoryListCubit>(() => CategoryListCubit(di()));

  // Tag --------------------------
  di.registerLazySingleton<TagDataProvider>(() => TagDataProvider(di()));
  di.registerLazySingleton<TagRepositoryContract>(() => TagRepository(di()));

  di.registerLazySingleton<QueryTags>(() => QueryTags(di()));

  di.registerFactory<TagListCubit>(() => TagListCubit(di()));


}