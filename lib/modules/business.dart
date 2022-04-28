import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp1/NewsStates.dart';
import 'package:newsapp1/cubit.dart';
import 'package:newsapp1/shared/components/componen/components.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Business extends StatelessWidget {
  const Business({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return ConditionalBuilderRec(
          condition: list.length > 0,
          builder: (context) => ScreenTypeLayout(
            mobile: ListView.separated(
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
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          NewsItem(list[index], context, index, true),
                      separatorBuilder: (context, index) => Container(
                            width: 180,
                            height: 1.5,
                            margin: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 5),
                            color: Color(0xffc2a671),
                          ),
                      itemCount: list.length),
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.black26,
                        height: double.infinity,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image(
                                  image: NetworkImage(
                                      "${list[NewsCubit.get(context).selectedItem]['urlToImage']}")),
                            ),
                            Expanded(
                              child: Text(
                                "${list[NewsCubit.get(context).selectedItem]['description']}",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        )))
              ],
            ),
            breakpoints:
                ScreenBreakpoints(tablet: 400, watch: 100, desktop: 600),
          ),
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
