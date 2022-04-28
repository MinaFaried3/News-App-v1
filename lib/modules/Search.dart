import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp1/NewsStates.dart';
import 'package:newsapp1/cubit.dart';
import 'package:newsapp1/shared/components/componen/components.dart';

import '../main_cubit/Main_Cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {

      },
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.only(top: 30,right: 20,left: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: search,
                  keyboardType: TextInputType.text,
                  validator: (String ? val){
                    if(val!.isEmpty){
                      return 'enter ';
                    }
                  },
                  decoration: InputDecoration(
                    label: Text('Search'),
                    prefixIcon: Icon(Icons.search, color: MainCubit.get(context).isDark! ? Color(0xfff6ebd1):Color(0xff264B5E),),
                    enabledBorder: OutlineInputBorder(
                        borderSide: MainCubit.get(context).isDark! ?  BorderSide(width: 3,color: Color(0xfff6ebd1)) :  BorderSide(width: 3,color: Color(0xff264B5E)),
                        borderRadius: BorderRadius.circular(19)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: MainCubit.get(context).isDark! ?  BorderSide(width: 3,color: Color(0xfff6ebd1)) :  BorderSide(width: 3,color: Color(0xff264B5E)),
                        borderRadius: BorderRadius.circular(28)
                    ),

                    labelStyle: TextStyle(
                        color:  MainCubit.get(context).isDark! ? Color(0xfff6ebd1):Color(0xff264B5E)
                    ),
                    hoverColor:  MainCubit.get(context).isDark! ? Color(0xfff6ebd1):Color(0xff264B5E),
                    focusColor:  MainCubit.get(context).isDark! ? Color(0xfff6ebd1):Color(0xff264B5E),

                  ),
                  cursorColor:  MainCubit.get(context).isDark! ? Color(0xfff6ebd1):Color(0xff264B5E),
                  style: TextStyle(
                      color:  MainCubit.get(context).isDark! ? Color(0xfff6ebd1):Color(0xff264B5E)
                  ),
                  onChanged: (value){
                      NewsCubit.get(context).getSearch(value);
                  },
                ),
                Expanded(
                    child: ListMino(list, context)
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
