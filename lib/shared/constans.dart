import 'package:flutter/material.dart';
import 'package:newsapp/modules/shop_app/login/shop_login_screen.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';

void signOut (context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ShopLoginScreen(),
        ),
            (route) => false);
  });
}

String token='';