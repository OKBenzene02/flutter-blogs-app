import "package:blogs_app/core/theme/app_pallet.dart";
import "package:flutter/material.dart";

class AuthGradientButton extends StatelessWidget {
  final String btnText;
  const AuthGradientButton({super.key, required this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(400, 55),
          backgroundColor: AppPallete.transparentColor,
          elevation: 0,
          shadowColor: AppPallete.transparentColor,
        ),
        onPressed: () {},
        child: Text(
          btnText,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
