import 'package:newsapp/models/shop_app/register_model.dart';

abstract class RegisterStates{}

 class RegisterInitialStates extends RegisterStates{}

class RegisterLoadingStates extends RegisterStates{}

class RegisterSuccessStates extends RegisterStates
{
 RegisterModel registerModel;
 RegisterSuccessStates(this.registerModel);
}

class RegisterErrorStates extends RegisterStates{}