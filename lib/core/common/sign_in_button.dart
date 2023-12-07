import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/features/controller/auth_controller.dart';
import 'package:reddit_clone/theme/pallet.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({
    super.key,
  });

  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: ()=> signInWithGoogle(context,ref),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Pallete.greyColor, borderRadius: BorderRadius.circular(30)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(Constants.googlePath)),
            SizedBox(
              width: 5,
            ),
            Text(
              "Continue with Google",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
