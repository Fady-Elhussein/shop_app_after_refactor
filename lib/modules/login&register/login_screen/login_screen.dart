import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../const/constants.dart';
import '../../../layout/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/custom_textformfiled.dart';
import '../../../shared/cubit/shop_login_cubit/shop_login_cubit.dart';
import '../../../shared/cubit/shop_login_cubit/shop_login_states.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../register_screen/register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => ShopLoginCubit()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40.0,
                      ),
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        readOnly: false,
                        keyboardType: TextInputType.emailAddress,
                        text: 'Email Address',
                        prefixIcon: const Icon(Icons.email),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      CustomTextFormField(
                        readOnly: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required.';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        text: "Password",
                        prefixIcon: const Icon(Icons.password),
                        obscureText: _isPasswordVisible,
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                                email: _emailController.text,
                                password: _passwordController.text);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      BlocConsumer(
                        builder: (context, state) {
                          return state is! ShopLoginLoadingState
                              ? defaultButton(
                                  width: double.infinity,
                                  function: () {
                                    if (_formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                          email: _emailController.text,
                                          password: _passwordController.text);
                                    }
                                    return null;
                                  },
                                  text: 'Login',
                                )
                              : const Center(
                                  child: CircularProgressIndicator());
                        },
                        listener: (context, state) {
                          if (state is ShopLoginSuccessState) {
                            if (state
                                .loginModel.status!) // true ب  status  لو ال
                            {
                              CacheHelper.saveData(
                                key: 'token',
                                value: state.loginModel.data?.token,
                              ).then(
                                (value) {
                                  token = state.loginModel.data?.token;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ShopLayout(),
                                    ),
                                  );
                                },
                              );
                              showToast(
                                  context: context,
                                  msg: state.loginModel.message!,
                                  state: ToastStates.success);
                            } else {
                              showToast(
                                  context: context,
                                  msg: state.loginModel.message!,
                                  state: ToastStates.error);
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Don\'t have an account?',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: ' Register',
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\tt  have an account?'),
                        ],
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Design By :'),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Husseiny',
                              style: TextStyle(
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
