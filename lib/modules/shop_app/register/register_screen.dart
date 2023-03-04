import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:newsapp/modules/shop_app/login/shop_login_screen.dart';
import 'package:newsapp/modules/shop_app/register/cubit/cubit.dart';
import 'package:newsapp/modules/shop_app/register/cubit/states.dart';
import 'package:newsapp/shared/components.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var firstNameController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessStates) {
            if (state.registerModel.status) {
              CacheHelper.saveData(
                      key: 'token', value: state.registerModel.data!.token)
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopLoginScreen(),
                    ),
                    (route) => false);
              });
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Register To App',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Register Now Your Account',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextFormField(
                        controller: firstNameController,
                        labelText: 'Your Name',
                        preffixIcon: Icons.account_circle_outlined,
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultTextFormField(
                        controller: phoneController,
                        labelText: 'Phone Number',
                        preffixIcon: Icons.phone_android,
                        type: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultTextFormField(
                        controller: emailController,
                        labelText: 'Your Email',
                        preffixIcon: Icons.email,
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultTextFormField(
                        controller: passwordController,
                        labelText: 'Your Password',
                        preffixIcon: Icons.lock_outline_rounded,
                        type: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ConditionalBuilder(
                          condition: state is! RegisterLoadingStates,
                          builder: (context) => MaterialButton(
                            elevation: 10,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.black,
                            onPressed: () {
                              RegisterCubit.get(context).GetRegiterModel(
                                email: emailController.text,
                                password: passwordController.text,
                                name: firstNameController.text,
                                phone: phoneController.text,
                              );
                            },
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ],
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
