import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp1/NewsStates.dart';
import 'package:newsapp1/cubit.dart';
import 'package:newsapp1/main_cubit/Main_Cubit.dart';
import 'package:newsapp1/modules/Search.dart';
import 'package:newsapp1/modules/settings.dart';
import 'package:newsapp1/modules/settingsSearch.dart';
import 'package:newsapp1/shared/network/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context,state) {
        var cubit = NewsCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text("News App"),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
              },
                  icon: Icon(Icons.search_outlined)),
              IconButton(onPressed: (){
                  MainCubit.get(context).Change_theme();
              },
                  icon: Icon(Icons.brightness_2_outlined)),

            ],
          ),

          body: cubit.Screens[cubit.current],
          floatingActionButton: FloatingActionButton(
            onPressed: (){

            },
            child: Icon(Icons.account_circle_outlined,size: 36,),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.change(index);
            },
            currentIndex: cubit.current,
            items: cubit.bottomItem,
          ),
        );
      },
    );
  }
}
