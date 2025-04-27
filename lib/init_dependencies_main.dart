part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.appUrl, anonKey: AppSecrets.apiKey);

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(() =>
      ConnectionCheckerImplementation(internetConnection: serviceLocator()));
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));
}

void _initAuth() {
  /// Starting from the core Register factory for AuthRemoteDataSourceImplementation
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() =>
        AuthRemoteDataSourceImplementation(
            supabaseClient: serviceLocator<SupabaseClient>()))

    /// Next AuthRepositoryImplementation
    ..registerFactory<AuthRepository>(() => AuthRepositoryImplementation(
        remoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator()))

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
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  // Data source
  serviceLocator
    ..registerFactory<BlogRemoteDataSources>(
      () => BlogRemoteDataSourceImplementation(
        supabaseClient: serviceLocator<SupabaseClient>(),
      ),
    )
    /// Local data source for blogs application
    ..registerFactory<BlogLocalDataSources>(
      () => BlogLocaDataSourceImplementation(
        box: serviceLocator<Box>(),
      ),
    )
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImplementation(
        blogRemoteDataSources: serviceLocator(),
        blogLocalDataSources: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )

    // Usecase for blog upload
    ..registerFactory(() => BlogUpload(blogRepository: serviceLocator()))

    // Usecase for get all blogs
    ..registerFactory(() => GetAllBlogs(blogRepository: serviceLocator()))

    // Blog bloc
    ..registerLazySingleton(() => BlogBloc(
          uploadBlog: serviceLocator(),
          getAllBlogs: serviceLocator(),
        ));
}
