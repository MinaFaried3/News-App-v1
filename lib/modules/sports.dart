import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp1/NewsStates.dart';
import 'package:newsapp1/cubit.dart';
import 'package:newsapp1/shared/components/componen/components.dart';

class Sports extends StatelessWidget {
  const Sports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).sports;
        return ConditionalBuilderRec(
          condition: list.length > 0,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  NewsItem(list[index], context, index, false),
              separatorBuilder: (context, index) => Container(
                    width: 180,
                    height: 1.5,
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    color: Color(0xffc2a671),
                  ),
              itemCount: list.length),
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: Color(0xffffddad),
            ),
          ),
        );
      },
    );
  }
}
