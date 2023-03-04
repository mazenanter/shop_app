import 'package:newsapp/models/shop_app/add_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopSuccessState extends ShopStates {}

class ShopErrorState extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessFavoriteState extends ShopStates
{
  final AddFavoriteModel model;

  ShopSuccessFavoriteState(this.model);
}

class ShopErrorFavoriteState extends ShopStates {}

class ShopChangeFavoriteState extends ShopStates {}

class ShopSuccessGetFavoriteState extends ShopStates {}

class ShopErrorGetFavoriteState extends ShopStates {}

class ShopLoadingGetFavoriteState extends ShopStates {}



