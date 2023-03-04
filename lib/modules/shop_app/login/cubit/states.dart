import 'package:newsapp/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialStates extends ShopLoginStates{}

class ShopLoginSuccessStates extends ShopLoginStates
{
   ShopLoginModel loginModel;
  ShopLoginSuccessStates(this.loginModel);
}

class ShopLoginFailedStates extends ShopLoginStates{}

class ShopLoginLoadingStates extends ShopLoginStates{}

class ShopChangeSuffixIconStates extends ShopLoginStates{}