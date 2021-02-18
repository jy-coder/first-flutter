import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/screens/pages/webview_screen.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleScreen extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String pubDate;
  final String source;
  final String category;
  final String link;

  ArticleScreen(
      {this.id,
      this.title,
      this.description,
      this.imageUrl,
      this.pubDate,
      this.source,
      this.category,
      this.link});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = dateFormat.parse(pubDate);
    String timeAgo = timeago.format(dateTime);

    return SingleChildScrollView(
      child: Container(
        child: Wrap(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: CachedNetworkImageProvider(
                  this.imageUrl,
                  cacheKey: this.id.toString(),
                ),
                fit: BoxFit.cover,
              )),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    title,
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
                                source,
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
                      description,
                      style: CustomTextStyle.normal(context),
                    ),
                  ),
                  Container(
                    child: OutlineButton(
                      padding: EdgeInsets.all(20),
                      child: Text("Visit Website",
                          style: CustomTextStyle.normal(context)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebViewScreen(this.link)));
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
