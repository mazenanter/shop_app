import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/shop_app/shop_layout.dart';
import 'package:newsapp/modules/shop_app/login/cubit/cubit.dart';
import 'package:newsapp/modules/shop_app/login/cubit/states.dart';
import 'package:newsapp/modules/shop_app/register/register_screen.dart';
import 'package:newsapp/shared/components.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/styles/colors.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessStates) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopLayout(),
                    ),
                    (route) => true);
              });
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Login Now To 3nter Store',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        controller: emailController,
                        labelText: 'Email Address',
                        preffixIcon: Icons.email_outlined,
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextFormField(
                          controller: passwordController,
                          labelText: 'Password',
                          preffixIcon: Icons.lock_outline_rounded,
                          type: TextInputType.visiblePassword,
                          suffixIcon: ShopLoginCubit.get(context).suffixIcon,
                          obscureText: ShopLoginCubit.get(context).isPassword,
                          function: () {
                            ShopLoginCubit.get(context).changeSuffixIcon();
                          }),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ConditionalBuilder(
                          condition: state is! ShopLoginLoadingStates,
                          builder: (context) => MaterialButton(
                            elevation: 10,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.black,
                            onPressed: () {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            },
                            child: Text(
                              'LOGIN',
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
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t Have An Account ?',
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ));
                              },
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
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
