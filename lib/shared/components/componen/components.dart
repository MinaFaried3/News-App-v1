import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:newsapp1/cubit.dart';

Widget NewsItem(article, context, int index, bool val) {
  return Container(
    color: NewsCubit.get(context).selectedItem == index && val
        ? Colors.black26
        : null,
    child: InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder:(context)=> WebViewscreen(article['url'])));
        NewsCubit.get(context).select(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                        '${article['urlToImage']}',
                      ),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 90,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget ListMino(list, context) {
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
}
