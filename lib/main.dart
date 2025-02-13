import "package:blogs_app/core/theme/theme.dart";
import "package:blogs_app/features/auth/presentation/pages/login_page.dart";
import "package:blogs_app/features/auth/presentation/pages/signup_page.dart";
import "package:flutter/material.dart";
import "core/theme/theme.dart";

void main(List<String> args) {
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
