import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../const/constants.dart';
import '../../../models/search_model.dart';
import 'search_states.dart';
import '../../network/end_points.dart';
import '../../network/remote/dio_helper.dart';  

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
void search(String text){
  emit(SearchLoadingState());
  DioHelper.postData(
      url: sEARCH,
      token: token,
      data: {
    'text':text,
      }
  ).then((value){
    searchModel=SearchModel.fromJson(value?.data);
    emit(SearchSuccessState());
  }).catchError((onError){
    print(onError.toString());
    emit(SearchErrorState());
  });

}


}
