import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/models/shop_app/register_model.dart';
import 'package:newsapp/modules/shop_app/register/cubit/states.dart';
import 'package:newsapp/shared/network/end_point.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit():super(RegisterInitialStates());
  static RegisterCubit get(context)=>BlocProvider.of(context);

  RegisterModel? registerModel;

  void GetRegiterModel({
  required String name,
    required String phone,
    required String email,
    required String password,
  })
  {
    emit(RegisterLoadingStates());

    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name':name,
          'phone':phone,
          'email':email,
          'password':password,
        },
    ).then((value)
    {
      print(value.data);
      registerModel=RegisterModel.fromJson(value.data);
      emit(RegisterSuccessStates(registerModel!));
    }).catchError((onError)
    {
      print(onError.toString());
      emit(RegisterErrorStates());
    });

  }
}