import "package:blogs_app/core/secrets/app_secrets.dart";
import "package:blogs_app/core/theme/theme.dart";
import "package:blogs_app/features/auth/data/repository/auth_repository_implementation.dart";
import "package:blogs_app/features/auth/data/sources/auth_remote_data_source.dart";
import "package:blogs_app/features/auth/domain/usecases/user_sign_up.dart";
import "package:blogs_app/features/auth/presentation/bloc/auth_bloc.dart";
import "package:blogs_app/features/auth/presentation/pages/login_page.dart";
import "package:blogs_app/features/auth/presentation/pages/signup_page.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "core/theme/theme.dart";

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
      url: AppSecrets.appUrl, anonKey: AppSecrets.apiKey);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(
            authRepository: AuthRepositoryImplementation(
              remoteDataSource: AuthRemoteDataSourceImplementation(
                  supabaseClient: supabase.client),
            ),
          ),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Blogs Application",
      theme: AppTheme.darkThemeMode,
      home: const SignupPage(),
    );
  }
}
