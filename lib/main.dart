import "package:blogs_app/core/theme/theme.dart";
import "package:blogs_app/features/auth/presentation/bloc/auth_bloc.dart";
import "package:blogs_app/features/auth/presentation/pages/login_page.dart";
import "package:blogs_app/init_dependencies.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Blogs Application",
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
