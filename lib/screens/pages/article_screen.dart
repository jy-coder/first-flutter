import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/shared/title.dart';
import 'package:newheadline/utils/date.dart';
import 'package:newheadline/utils/models.dart';

class ArticleScreen extends StatelessWidget {
  static final routeName = '/article';

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    String pubDate = formatDate(args.pubDate);

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
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    args.imageUrl,
                    cacheKey: args.id.toString(),
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
                                  pubDate,
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
