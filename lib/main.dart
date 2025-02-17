import "package:blogs_app/core/secrets/app_secrets.dart";
import "package:blogs_app/core/theme/theme.dart";
import "package:blogs_app/features/auth/presentation/pages/login_page.dart";
import "package:blogs_app/features/auth/presentation/pages/signup_page.dart";
import "package:flutter/material.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "core/theme/theme.dart";

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: AppSecrets.appUrl, anonKey: AppSecrets.apiKey);
  runApp(const MyApp());
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
