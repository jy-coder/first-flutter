import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/provider/auth.dart';
import 'package:newheadline/provider/home.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/home/recommend_pageview.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:newheadline/widgets/share_button.dart';
import 'package:provider/provider.dart';
import 'package:newheadline/widgets/menu_button.dart';

class HomeCard extends StatefulWidget {
  final int id;
  final String title;
  final String imageUrl;
  final String summary;
  final String link;
  final String description;
  final String pubDate;
  final String source;
  final String category;

  HomeCard(
    this.id,
    this.title,
    this.imageUrl,
    this.summary,
    this.link,
    this.description,
    this.pubDate,
    this.source,
    this.category,
  );

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool showFullSummary = false;

  Future<void> saveReadingHistory(int articleId, String token) async {
    try {
      String url = "$HISTORY_URL/?article=$articleId";
      var result = await APIService().post(url, token);
    } on Exception catch (e) {
      print(e);
    }
  }

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider hProvider = Provider.of<HomeProvider>(context, listen: false);
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);
    Auth aProvider = Provider.of<Auth>(context, listen: true);

    TextStyle defaultStyle =
        CustomTextStyle.cardSummary(context, tProvider.fontSize);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return Container(
      child: Card(
          child: Wrap(
        children: [
          InkWell(
            onTap: () async {
              await saveReadingHistory(widget.id, aProvider.token);
              hProvider.setPageViewArticle(widget.id);
              Navigator.pushNamed(
                context,
                RecommendPageViewScreen.routeName,
                arguments: widget.id,
              );
            },
            child: Column(
              children: [
                // Container(
                //   height: 300,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //     image: CachedNetworkImageProvider(widget.imageUrl,
                //         cacheKey: widget.id.toString()),
                //     fit: BoxFit.cover,
                //   )),
                // ),
                Column(
                  children: [
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
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
                              Expanded(flex: 1, child: MenuBtn(widget.id)),
                              Expanded(
                                  flex: 1, child: ShareBtn(link: widget.link))
                            ]),
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
