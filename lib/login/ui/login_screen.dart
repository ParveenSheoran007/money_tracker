import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/dashboard/ui/dashboard_screen.dart';
import 'package:money_tracker/login/provider/auth_provider.dart';
import 'package:money_tracker/login/ui/register_screen.dart';
import 'package:money_tracker/shard/app_colors.dart';
import 'package:money_tracker/shard/app_string.dart';
import 'package:money_tracker/shard/app_text_field.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, widget) {
          return Center(
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset(
                          'assets/image/login.jpg',
                          height: 200,
                          width: 150,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            const Text(
                              login,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              loginText,
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              email,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            AppTextField(
                              controller: emailController,
                              hintText: emailFieldHint,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              password,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            AppTextField(
                              controller: passwordController,
                              obscureText:
                                  authProvider.isVisible ? false : true,
                              hintText: passwordFieldHint,
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  authProvider.setPasswordFieldStatus();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            InkWell(
                              onTap: () {
                                loginUser();
                              },
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: textButtonColor,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Text(
                                  login,
                                  style: TextStyle(color: buttonTextColor),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(noAccount),
                                const SizedBox(
                                  width: 4,
                                ),
                                TextButton(
                                    onPressed: () {
                                      openRegisterUserScreen();
                                    },
                                    child: const Text(
                                      register,
                                      style: TextStyle(color: textButtonColor),
                                    )),
                              ],
                            )
                          ],
                        ),
                        Positioned(
                          child: authProvider.isLoading
                              ? const CircularProgressIndicator()
                              : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void openRegisterUserScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const RegisterScreen();
    }));
  }

  Future<void> loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const DashboardScreen();
      }));
    } else {
      if (kDebugMode) {
        print('Please fill in both email and password.');
      }
    }
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const DashboardScreen();
      }));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      }));
    }
  }
}
