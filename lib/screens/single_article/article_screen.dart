import 'package:flutter/material.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/single_article/webview_screen.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:newheadline/utils/common.dart';
import 'package:provider/provider.dart';

class ArticleScreen extends StatefulWidget {
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
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    String timeAgo = formatDate(widget.pubDate);
    ThemeProvider tProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Container(
        child: Wrap(
          children: [
            Container(
              height: 300,
             
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: CustomTextStyle.title1(context, tProvider.fontSize),
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
                                style: CustomTextStyle.small(
                                    context, tProvider.fontSize),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.source),
                              Text(
                                widget.source,
                                style: CustomTextStyle.small(
                                    context, tProvider.fontSize),
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
                      widget.description,
                      style:
                          CustomTextStyle.normal(context, tProvider.fontSize),
                    ),
                  ),
                  Container(
                    child: OutlineButton(
                      padding: EdgeInsets.all(20),
                      child: Text("Visit Website",
                          style: CustomTextStyle.normal(
                              context, tProvider.fontSize)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebViewScreen(this.widget.link)));
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
