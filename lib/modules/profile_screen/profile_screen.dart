import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/components/custom_textformfiled.dart';
import '../../shared/cubit/shop_cubit/shop_cubit.dart';
import '../../shared/cubit/shop_cubit/shop_state.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login&register/login_screen/login_screen.dart';
import '../update_profile_screen/update_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        nameController.text = cubit.userModel!.data!.name!;
        emailController.text = cubit.userModel!.data!.email!;
        phoneController.text = cubit.userModel!.data!.phone!;
        String userImage ='https://cdn-icons-png.flaticon.com/512/1077/1077012.png';
        if(cubit.userModel?.data !=null) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          CircleAvatar(
                            radius: 70.0,
                            backgroundImage: NetworkImage(userImage),
                          ),
                          Container(
                            color: Colors.transparent,
                            child: TextButton(
                              child: const Text('Edit',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateScreen(
                                              userImage: userImage,
                                              emailController: emailController,
                                              nameController: nameController,
                                              phoneController: phoneController),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CustomTextFormField(
                          controller: nameController,
                          readOnly: true,
                          keyboardType: TextInputType.name,
                          text: "Name",
                          prefixIcon: const Icon(Icons.person)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CustomTextFormField(
                          controller: emailController,
                          readOnly: true,
                          keyboardType: TextInputType.emailAddress,
                          text: "Email",
                          prefixIcon: const Icon(Icons.email)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CustomTextFormField(
                          controller: phoneController,
                          readOnly: true,
                          keyboardType: TextInputType.name,
                          text: "Phone",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.phone)),
                      const SizedBox(
                        height: 10.0,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: TextButton.icon(
                                onPressed: () {
                                  CacheHelper.removeData(key: 'token')
                                      ?.then((value) {
                                    if (value!) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                             ShopLoginScreen(),
                                          ),
                                              );
                                    }
                                    showToast(
                                        context: context,
                                        msg: 'Log out Done',
                                        state: ToastStates.error);
                                  });
                                },
                                icon: const Icon(
                                  Icons.power_settings_new,
                                ),
                                label: const Text(
                                  'Sign Out',
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }else
          {
            return const Center(child: CircularProgressIndicator(),);
          }

      },
    );
  }
}
