import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:newheadline/widgets/bookmark_button.dart';
import 'package:newheadline/widgets/menu_button.dart';
import 'package:newheadline/widgets/share_button.dart';
import 'package:provider/provider.dart';
import 'package:newheadline/widgets/like_button.dart';
import 'package:newheadline/widgets/slidable.dart';

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
  final int similarity;
  final String similarHeadline;
  final int likeCount;

  ArticleCard(
    this.id,
    this.title,
    this.imageUrl,
    this.summary,
    this.link,
    this.description,
    this.pubDate,
    this.source,
    this.category, {
    this.similarHeadline,
    this.similarity,
    this.historyDate,
    this.likeCount,
  });

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

Future<void> notInterestedAction(BuildContext context, int articleId) async {
  String url = "$NOT_INTERESTED_URL/?article=$articleId";
  await APIService().post(url);
}

Widget _slider(BuildContext context, int id, Widget articleCard) {
  return (SlidableWidget(
    background: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Not interested"),
          Icon(Icons.cancel),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        color: Colors.red,
      ),
    ),
    onSlided: () => {
      notInterestedAction(context, id),
    },
    child: articleCard,
  ));
}

class _ArticleCardState extends State<ArticleCard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

    Widget displayCards() {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.zero,
        child: Wrap(
          children: [
            InkWell(
              key: _scaffoldKey,
              onTap: () {
                aProvider.setShareLink(widget.link);
                aProvider.setCurrentArticleId(widget.id);
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
                      SizedBox(height: 10),
                      ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        dense: true,
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                capitalize(widget.category),
                                style: TextStyle(
                                  color: Colors.green[600],
                                ),
                              ),
                              Container(
                                child: aProvider.tab == "daily_read"
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Similar To ${widget.similarHeadline}",
                                                  style: CustomTextStyle.italic(
                                                      context,
                                                      tProvider.fontSize),
                                                ),
                                                Text(
                                                  "Similarity ${widget.similarity}",
                                                  style: CustomTextStyle.italic(
                                                      context,
                                                      tProvider.fontSize),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(height: 0),
                              ),
                              SizedBox(height: 10),
                              FittedBox(
                                  child: Align(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: widget.imageUrl,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          SizedBox(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                    height: 30,
                                    width: 30,
                                  ),
                                  errorWidget: (context, ud, error) =>
                                      Icon(Icons.error),
                                ),
                              )),
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
                    margin: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: defaultStyle,
                            children: <TextSpan>[
                              TextSpan(
                                text: truncateWithEllipsis(
                                  100,
                                  widget.summary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.source),
                                    Text(
                                      aProvider.subTab == "History" &&
                                              widget.historyDate != null
                                          ? "Viewed ${formatDate(widget.historyDate)}"
                                          : formatDate(widget.pubDate),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: aProvider.tab != "History" &&
                                                Auth().currentUser != null
                                            ? Row(children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(),
                                                ),
                                                aProvider.tab == "trend"
                                                    ? Expanded(
                                                        flex: 0,
                                                        child: Text(widget
                                                            .likeCount
                                                            .toString()),
                                                      )
                                                    : Container(),
                                                Expanded(
                                                  flex: 1,
                                                  child: LikeBtn(widget.id),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: BookmarkBtn(widget.id),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: ShareBtn(
                                                      link: widget.link),
                                                ),
                                              ])
                                            : Container(),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return aProvider.tab != "daily_read"
        ? Container(
            padding: EdgeInsets.all(8),
            child: displayCards(),
          )
        : _slider(
            context,
            widget.id,
            displayCards(),
          );
  }
}
