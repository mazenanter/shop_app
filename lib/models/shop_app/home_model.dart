class HomeModel
{
  bool status=true;
  HomeData? data;
  HomeModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData
{
  List<BannerModel>banners=[];
  List<ProductModel>products=[];

  HomeData.fromJson(Map<String,dynamic>json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel
{
  int? id;
  dynamic image;
  BannerModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];
  }

}

class ProductModel
{
  int id=1;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  dynamic image;
  dynamic name;
  bool inFavorite=false;
  bool? inCart;
  ProductModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorite=json['in_favorites'];
    inCart=json['in_cart'];
  }
}