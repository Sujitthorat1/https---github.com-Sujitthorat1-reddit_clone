import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/core/common/sign_in_button.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/features/controller/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        //
        centerTitle: true,
        title: const Image(
          image: AssetImage(Constants.logoPath),
          fit: BoxFit.cover,
          width: 40,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Skip",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: Column(
                children: [
                  const Text(
                    "Dive into anything",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Constants.loginEmotePath),
                            fit: BoxFit.contain)),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SignInButton()
                ],
              ),
            ),
    );
  }
}
