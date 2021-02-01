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
      body: SingleChildScrollView(
        child: Container(
          child: Wrap(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.network(
                  'https://via.placeholder.com/800x500',
                ),
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
                    Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.timelapse),
                                Text(
                                  timeAgo,
                                  style: CustomTextStyle.small(context),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.source),
                                Text(
                                  args.source,
                                  style: CustomTextStyle.small(context),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        args.description,
                        style: CustomTextStyle.normal(context),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
