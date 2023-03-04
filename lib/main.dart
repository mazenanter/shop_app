import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/shop_app/cubit/cubit.dart';
import 'package:newsapp/layout/shop_app/shop_layout.dart';
import 'package:newsapp/modules/shop_app/login/shop_login_screen.dart';
import 'package:newsapp/modules/shop_app/on_boarding/onBoarding_screen.dart';
import 'package:newsapp/shared/constans.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';
import 'package:newsapp/styles/themes.dart';

void main() async
{
  // بتضمن ان اللي قبل الران اب يشتغل قبل مالااب يشتغل
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  await CacheHelper.init();
  Widget? widget;

  bool onBoarding= CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

 if(onBoarding != null)
 {
   if(token!=null)

     widget = ShopLayout();
     else widget = ShopLoginScreen();
 }else
 {
   widget = OnBoardingScreen();
 }

  runApp(MyApp(
    onBoarding: onBoarding,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
 final bool? onBoarding;
 final Widget? startWidget;

 MyApp({this.onBoarding, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
       BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCatData()..getFavorites(),
       ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
        theme: lightTheme,
      ),
    );
  }
}
