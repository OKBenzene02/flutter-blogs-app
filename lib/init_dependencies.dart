import 'package:blogs_app/core/secrets/app_secrets.dart';
import 'package:blogs_app/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blogs_app/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:blogs_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blogs_app/features/auth/domain/usecases/current_user.dart';
import 'package:blogs_app/features/auth/domain/usecases/user_login.dart';
import 'package:blogs_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blogs_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecrets.appUrl, anonKey: AppSecrets.apiKey);

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  /// Starting from the core Register factory for AuthRemoteDataSourceImplementation
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() =>
        AuthRemoteDataSourceImplementation(
            supabaseClient: serviceLocator<SupabaseClient>()))

    /// Next AuthRepositoryImplementation
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImplementation(remoteDataSource: serviceLocator()))

    /// Next UserSignUp
    ..registerFactory(() => UserSignUp(authRepository: serviceLocator()))

    /// Adding a UserLogin Factory
    ..registerFactory(() => UserLogin(authRepository: serviceLocator()))

    /// Adding a session persistent factory for current user
    ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))

    /// Next AuthBloc that will implement both UserSignUp and UserLogin
    ..registerLazySingleton(
      () => AuthBloc(
        currentUser: serviceLocator(),
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
      ),
    );
}
