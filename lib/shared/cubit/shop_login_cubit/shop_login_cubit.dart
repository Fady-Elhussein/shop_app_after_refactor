import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/login_model.dart';
import '../../network/end_points.dart';
import '../../network/remote/dio_helper.dart';
import 'shop_login_states.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: lOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value?.data);
      print(loginModel?.status);
      print(loginModel?.message);
      print(loginModel?.data?.token);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((onError) {
      print("Error : $onError.toString()");
      emit(ShopLoginErrorState(onError.toString()));
    });
  }
  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: rEGISTER,
      data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value?.data);
      print(loginModel?.status);
      print(loginModel?.message);
      print(loginModel?.data?.token);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((onError) {
      print("Error : $onError.toString()");
      emit(ShopRegisterErrorState(onError.toString()));
    });
  }


  


}
