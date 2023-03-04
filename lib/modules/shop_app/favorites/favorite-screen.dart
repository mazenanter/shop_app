import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/shop_app/cubit/cubit.dart';
import 'package:newsapp/layout/shop_app/cubit/states.dart';
import 'package:newsapp/models/shop_app/add_favorites_model.dart';
import 'package:newsapp/models/shop_app/favorites_model.dart';
import 'package:newsapp/shared/constans.dart';
import 'package:timer_snackbar/timer_snackbar.dart';

class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {
        if (state is ShopSuccessFavoriteState) {
          if (!state.model.status)
          {
            timerSnackbar(
              context: context,
              contentText: "${state.model.message}",
              afterTimeExecute: () => print("Operation Execute."),
              second: 2,
              backgroundColor: Colors.red,
            );
          }if (state.model.status)
          {
            timerSnackbar(
              context: context,
              contentText: "${state.model.message}",
              afterTimeExecute: () => print("Operation Execute."),
              second: 2,
            );
          }
        }
      },
      builder: (context,state)
      {
        var favoritesModel =ShopCubit.get(context).favoritesModel!.data!.favdata;
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoriteState,
          builder: (context) =>ListView.separated(
            itemBuilder: (context,index)=>buildFavoritesList(favoritesModel[index],context),
            separatorBuilder: (context,index)=>Container(
              height: 1,
              color: Colors.black.withOpacity(.8),
            ),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.favdata.length,
          ),
          fallback: (context) =>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavoritesList(FavoritesData model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.product!.image),
                width: 120.0,
                height: 120.0,
              ),
              if (model.product!.discount!=0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product!.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.product!.price.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.product!.discount!=0)
                      Text(
                        model.product!.oldPrice.toString(),
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorite(model.product!.id);
                        print(token);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                        ShopCubit.get(context).favorites[model.product!.id]
                            ? Colors.blue
                            : Colors.black.withOpacity(.6),
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
