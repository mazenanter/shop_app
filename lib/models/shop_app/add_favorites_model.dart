class AddFavoriteModel
{
  bool status=false;
  String?message;
  AddFavoriteModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }
}
