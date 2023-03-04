import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/shop_app/cubit/states.dart';
import 'package:newsapp/models/shop_app/add_favorites_model.dart';
import 'package:newsapp/models/shop_app/categories_model.dart';
import 'package:newsapp/models/shop_app/favorites_model.dart';
import 'package:newsapp/models/shop_app/home_model.dart';
import 'package:newsapp/modules/shop_app/categories/categories_screen.dart';
import 'package:newsapp/modules/shop_app/favorites/favorite-screen.dart';
import 'package:newsapp/modules/shop_app/products/products_screen.dart';
import 'package:newsapp/modules/shop_app/setting/setting_screen.dart';
import 'package:newsapp/shared/constans.dart';
import 'package:newsapp/shared/network/end_point.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';
import 'package:newsapp/styles/colors.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit(): super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);

  List<Widget>bottomScreens=
  [
   ProductsScreen(),
   CategoriesScreen(),
   FavoriteScreen(),
   SettingScreen(),
  ];


  int currentIndex=0;

  void ChangeBottomNavIndex(int index)
  {
    currentIndex =index;
    emit(ShopChangeBottomNavState());
  }
  HomeModel? homeModel;

  Map<int,dynamic>favorites={};

  void getHomeData()
  {
    emit(ShopLoadingState());
   DioHelper.getData(
     url: HOME,
     token: token,
   ).then((value)
   {
     homeModel=HomeModel.fromJson(value.data);
     homeModel!.data!.products.forEach((element)
     {
       favorites.addAll({element.id:element.inFavorite,});
     });
    emit(ShopSuccessState());
   }).catchError((onError)
   {
     print(onError.toString());
     emit(ShopErrorState());
   });
  }

  CategoriesModel? categoriesModel;

  void getCatData()
  {
    emit(ShopLoadingState());
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value)
    {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  AddFavoriteModel? addFavoriteModel;

  void changeFavorite(int productId)
  {
    favorites[productId]=!favorites[productId];
    emit(ShopChangeFavoriteState());

    DioHelper.postData(
        url: FAVORITES,
        data:
        {
          "product_id": productId,
        },
      token: token,
    ).then((value)
    {
      addFavoriteModel=AddFavoriteModel.fromJson(value.data);
      emit(ShopSuccessFavoriteState(addFavoriteModel!));
      if(!addFavoriteModel!.status)
      {
        favorites[productId]=!favorites[productId];
      }else
      {
        getFavorites();
      }

      print(value.data);
    }).catchError((onError)
    {
      favorites[productId]=!favorites[productId];
      emit(ShopErrorFavoriteState());
      print(onError.toString());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoriteState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoriteState());
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopErrorGetFavoriteState());
    });
  }
}