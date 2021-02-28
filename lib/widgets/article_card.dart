import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/screens/pageview/article_pageview.dart';
import 'package:newheadline/utils/date.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:newheadline/widgets/menu_button.dart';
import 'package:provider/provider.dart';

class ArticleCard extends StatefulWidget {
  final int id;
  final String title;
  final String imageUrl;
  final String summary;
  final String link;
  final String description;
  final String pubDate;
  final String source;
  final String category;
  final String historyDate;

  ArticleCard(
      this.id,
      this.title,
      this.imageUrl,
      this.summary,
      this.link,
      this.description,
      this.pubDate,
      this.source,
      this.category,
      this.historyDate);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool showFullSummary = false;

  Future<void> saveReadingHistory(int articleId) async {
    String url = "$HISTORY_URL/?article=$articleId";
    await APIService().post(url);
  }

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: false);

    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 15.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);

    return Container(
      child: Card(
          child: Wrap(
        children: [
          InkWell(
            onTap: () async {
              if (aProvider.subTab != "History")
                await saveReadingHistory(widget.id);
              aProvider.setPageViewArticle(widget.id);
              Navigator.pushNamed(
                context,
                ArticlePageViewScreen.routeName,
                arguments: widget.id,
              );
            },
            child: Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: CachedNetworkImageProvider(widget.imageUrl,
                        cacheKey: widget.id.toString()),
                    fit: BoxFit.cover,
                  )),
                ),
                Column(
                  children: [
                    aProvider.subTab == "History" && widget.historyDate != ""
                        ? ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            dense: true,
                            subtitle: Text(
                              formatDate(widget.historyDate),
                            ),
                          )
                        : Container(),
                    ListTile(
                      title: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 8, child: Text(widget.title)),
                          aProvider.tab != "History"
                              ? Expanded(child: MenuBtn(widget.id))
                              : Container()
                        ],
                      )),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: defaultStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text: !showFullSummary
                                  ? truncateWithEllipsis(200, widget.summary)
                                  : truncateWithEllipsis(1000, widget.summary),
                            ),
                            TextSpan(
                                text: !showFullSummary
                                    ? 'Show More'
                                    : 'Show Less',
                                style: linkStyle,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      showFullSummary = !showFullSummary;
                                    });
                                  }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
