import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/search_screen/search_screen.dart';
import '../shared/components/components.dart';
import '../shared/cubit/shop_cubit/shop_cubit.dart';
import '../shared/cubit/shop_cubit/shop_state.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: ((context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData()),
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Salla'),
                actions: [
                  IconButton(onPressed: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  SearchScreen(),));
                  }, icon:const Icon(Icons.search)),


                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: bottomNavBar,
                currentIndex: ShopCubit.get(context).currentIndex,
                onTap: (index) {
                  ShopCubit.get(context).changeNavBar(index);
                },
              ),
              body: ShopCubit.get(context)
                  .screen[ShopCubit.get(context).currentIndex],
            );
          },
        ));
  }
}
