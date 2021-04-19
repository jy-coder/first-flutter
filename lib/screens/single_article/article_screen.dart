import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/single_article/related_screen.dart';
import 'package:newheadline/screens/single_article/webview_screen.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:newheadline/utils/common.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleScreen extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String pubDate;
  final String source;
  final String category;
  final String link;

  ArticleScreen({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.pubDate,
    this.source,
    this.category,
    this.link,
  });

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

Future<void> saveReadingHistory(int articleId) async {
  String url = "$HISTORY_URL/?article=$articleId";
  var result = await APIService().post(url);
}

class _ArticleScreenState extends State<ArticleScreen> {
  List<Article> relatedArticles = [];

  @override
  void didChangeDependencies() {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    () async {
      await aProvider.fetchSimilarArticles();
    }();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String timeAgo = formatDate(widget.pubDate);
    ThemeProvider tProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification &&
              scrollNotification.metrics.pixels ==
                  scrollNotification.metrics.maxScrollExtent &&
              aProvider.tab != "Setting") {
            saveReadingHistory(aProvider.articleId);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            child: Wrap(
              children: [
                Container(
                    height: 300,
                    width: 500,
                    child: Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => SizedBox(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                          height: 30,
                          width: 30,
                        ),
                        errorWidget: (context, ud, error) => Icon(Icons.error),
                      ),
                    )),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Text(
                        widget.title,
                        style:
                            CustomTextStyle.title1(context, tProvider.fontSize),
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
                          style: CustomTextStyle.normal(
                              context, tProvider.fontSize),
                        ),
                      ),
                      Text(
                        "More Articles:",
                        style:
                            CustomTextStyle.title1(context, tProvider.fontSize),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ...aProvider.relatedArticle
                                .map(
                                  (Article a) => GestureDetector(
                                      child: Column(
                                        children: [
                                          Text(
                                            a.title,
                                            textAlign: TextAlign.start,
                                            style:
                                                CustomTextStyle.underlinelink(
                                                    context,
                                                    tProvider.fontSize),
                                          ),
                                          SizedBox(height: 10)
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          "RelatedScreen",
                                          arguments: ScreenArguments(
                                            a.articleId,
                                            a.title,
                                            a.description,
                                            a.imageUrl,
                                            a.pubDate,
                                            a.source,
                                            a.category,
                                            a.link,
                                          ),
                                        );
                                      }),
                                )
                                .toList(),
                            SizedBox(height: 20),
                          ],
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
        ));
  }
}
