import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'const/constants.dart';
import 'layout/shop_layout.dart';
import 'modules/login&register/login_screen/login_screen.dart';
import 'modules/onboarding_screen/onboarding.dart';
import 'shared/cubit/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool boardingShown = CacheHelper.getData(key: 'boardingShown') ?? false;
  token = CacheHelper.getData(key: 'token') ?? 'false';
  Widget widget;
  // bool? isDark=CacheHelper.getBoolean(key: 'isDark');
  if (boardingShown == true) {
    if (token != 'false') {
      widget = const ShopLayout();
    } else {
      widget =  ShopLoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  )
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startWidget,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
    );
  }



}
