import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/models/shop_app/login_model.dart';
import 'package:newsapp/modules/shop_app/login/cubit/states.dart';
import 'package:newsapp/shared/network/end_point.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';
class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit ():super (ShopLoginInitialStates());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
  required String email,
    required String password,

  })
  {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email':email,
          'password':password,
        },
    ).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopLoginSuccessStates(loginModel!));
    }).catchError((onError){
      print(onError.toString());
      emit(ShopLoginFailedStates());
    });
  }
  bool isPassword =true;
  IconData suffixIcon = Icons.remove_red_eye_outlined;
  void changeSuffixIcon()
  {
    isPassword =!isPassword;
    suffixIcon= isPassword ? Icons.remove_red_eye_outlined:Icons.visibility_off;
    emit(ShopChangeSuffixIconStates());
  }
}