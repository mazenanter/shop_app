import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/shop_app/cubit/cubit.dart';
import 'package:newsapp/layout/shop_app/cubit/states.dart';
import 'package:newsapp/models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    var catModel = ShopCubit.get(context).categoriesModel;
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildCategories(catModel!.data!.data[index]),
          separatorBuilder: (context,index)=>SizedBox(
            height: 10,
          ),
          itemCount: catModel!.data!.data.length,
        );
      },
    );
  }

  Widget buildCategories(CatDataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(
          image: NetworkImage('${model.image}'),
          height: 80,
          width: 80,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}
