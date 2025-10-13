import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/custom_textformfiled.dart';
import '../../../shared/cubit/shop_login_cubit/shop_login_cubit.dart';
import '../../../shared/cubit/shop_login_cubit/shop_login_states.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../login_screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var conformpasswordcontroller = TextEditingController();
  var fnameController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool passwordvisable = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) // true ب  status  لو ال
            {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data?.token,
              ).then(
                (value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopLoginScreen(),
                      ),
                      (route) => false);
                },
              );
              showToast(
                  context: context,
                  msg: state.loginModel.message!,
                  state: ToastStates.success);
            } else {
              showToast(
                context: context,
                msg: passwordcontroller.text == conformpasswordcontroller.text
                    ? state.loginModel.message!
                    : "password Not Match",
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(
                color: Colors.black,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        CustomTextFormField(
                          readOnly: false,
                          controller: fnameController,
                          keyboardType: TextInputType.name,
                          text: 'Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required.';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.people),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        CustomTextFormField(
                          readOnly: false,
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          text: 'Email Address',
                          prefixIcon: const Icon(Icons.email),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email Address is required.';
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
                              return 'password is required.';
                            }
                            return null;
                          },
                          controller: passwordcontroller,
                          keyboardType: TextInputType.visiblePassword,
                          text: "Password",
                          prefixIcon: const Icon(Icons.password),
                          obscureText: passwordvisable,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (passwordvisable == true) {
                                    passwordvisable = false;
                                  } else {
                                    passwordvisable = true;
                                  }
                                });
                              },
                              icon: passwordvisable
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        CustomTextFormField(
                          readOnly: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Conform password ';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.password),
                          controller: conformpasswordcontroller,
                          keyboardType: TextInputType.visiblePassword,
                          text: "Conform Password",
                          obscureText: passwordvisable,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        CustomTextFormField(
                          readOnly: false,
                          controller: phoneController,
                          keyboardType: TextInputType.name,
                          text: 'Phone',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone is required.';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.phone),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        state is! ShopRegisterLoadingState
                            ? defultButton(
                                width: double.infinity,
                                function: () {
                                  if (formkey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userRegister(
                                        email: emailcontroller.text,
                                        name: fnameController.text,
                                        phone: phoneController.text,
                                        password: passwordcontroller.text ==
                                                conformpasswordcontroller.text
                                            ? passwordcontroller.text
                                            : 'Err');
                                  }
                                  return null;
                                },
                                text: 'Register',
                              )
                            : const CircularProgressIndicator(),
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
          );
        },
      ),
    );
  }
}
