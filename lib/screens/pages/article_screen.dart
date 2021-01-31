import 'package:flutter/material.dart';
import 'package:newheadline/shared/title.dart';
import 'package:newheadline/utils/models.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleScreen extends StatelessWidget {
  static final routeName = '/article';

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = dateFormat.parse(args.pubDate);
    String timeAgo = timeago.format(dateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Card(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                'https://via.placeholder.com/800x500',
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text(
                      args.title,
                      style: CustomTextStyle.title1(context),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Icon(Icons.lock_clock),
                        Text(
                          timeAgo,
                          style: CustomTextStyle.small(context),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          // Text(
          //   args.title,
          //   style: CustomTextStyle.title1(context),
          // ),
          //   ],
          // ),
        ),
      ),
    );

    // child: Text("hello"),
  }
}
