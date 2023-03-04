import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/shop_app/cubit/cubit.dart';
import 'package:newsapp/layout/shop_app/cubit/states.dart';
import 'package:newsapp/models/shop_app/categories_model.dart';
import 'package:newsapp/models/shop_app/home_model.dart';
import 'package:newsapp/shared/constans.dart';
import 'package:timer_snackbar/timer_snackbar.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
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
      builder: (context, state) {
        var model = ShopCubit.get(context).homeModel;
        var catModel = ShopCubit.get(context).categoriesModel;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => buildProduct(model!, catModel!, context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildProduct(HomeModel model, CategoriesModel catModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(
                        e.image,
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                viewportFraction: 1,
                autoPlayAnimationDuration: Duration(
                  seconds: 1,
                ),
                autoPlayInterval: Duration(
                  seconds: 3,
                ),
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                initialPage: 0,
                reverse: false,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoriesItem(catModel.data!.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: catModel.data!.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.black.withOpacity(.8),
                    height: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'New Product',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                color: Colors.grey[300],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1 / 1.62,
                  children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        buildProductItems(model.data!.products[index], context),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildProductItems(ProductModel model, context) => Container(
    height: 200,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Discount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${model.price.round()}\$',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}\$',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      print(token);
                      ShopCubit.get(context).changeFavorite(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor:
                          ShopCubit.get(context).favorites[model.id]
                              ? Colors.blue
                              : Colors.black.withOpacity(.6),
                      child: Icon(
                        Icons.favorite_border,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoriesItem(CatDataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
              '${model.image}',
            ),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(.8),
            child: Text(
              '${model.name}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
}
