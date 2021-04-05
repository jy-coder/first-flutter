import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/single_article/article_pageview.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:newheadline/utils/common.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:newheadline/widgets/menu_button.dart';
import 'package:newheadline/widgets/share_button.dart';
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

  ArticleCard(this.id, this.title, this.imageUrl, this.summary, this.link,
      this.description, this.pubDate, this.source, this.category,
      {this.historyDate});

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool showFullSummary = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> saveReadingHistory(int articleId) async {
    String url = "$HISTORY_URL/?article=$articleId";
    var result = await APIService().post(url);
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
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);

    TextStyle defaultStyle =
        CustomTextStyle.cardSummary(context, tProvider.fontSize);
    TextStyle linkStyle = TextStyle(color: Colors.blue);

    return Container(
      child: Card(
          child: Wrap(
        children: [
          InkWell(
            key: _scaffoldKey,
            onTap: () {
              aProvider.setShareLink(widget.link);
              if (aProvider.tab != "profile") {
                saveReadingHistory(widget.id);
              }
              aProvider.setPageViewArticle(widget.id);
              Navigator.of(context).pushNamed(
                ArticlePageViewScreen.routeName,
                arguments: widget.id,
              );
            },
            child: Column(
              children: [
                Column(
                  children: [
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              capitalize(widget.category),
                              style: TextStyle(color: Colors.green[600]),
                            ),
                            Text(widget.source),
                            Text(
                              aProvider.subTab == "History" &&
                                      widget.historyDate != null
                                  ? "viewed: ${formatDate(widget.historyDate)}"
                                  : formatDate(widget.pubDate),
                            ),
                          ]),
                    ),
                    ListTile(
                      title: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                              widget.title,
                              style: CustomTextStyle.cardTitle(
                                  context, tProvider.fontSize),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Column(children: [
                              aProvider.tab != "History" &&
                                      Auth().currentUser != null
                                  ? Expanded(flex: 1, child: MenuBtn(widget.id))
                                  : Container(),
                              Expanded(
                                  flex: 1, child: ShareBtn(link: widget.link))
                            ]),
                          )
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
