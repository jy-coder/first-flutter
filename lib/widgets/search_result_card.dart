import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/screens/pageview/search_pageview.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';

class SearchResultCard extends StatefulWidget {
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

  SearchResultCard(
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
  _SearchResultCardState createState() => _SearchResultCardState();
}

class _SearchResultCardState extends State<SearchResultCard> {
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
    return Container(
      child: Container(
        child: Wrap(
          children: [
            InkWell(
              onTap: () async {
                await saveReadingHistory(widget.id);
                Navigator.pushNamed(
                  context,
                  SearchPageViewScreen.routeName,
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  widget.title,
                                  style: CustomTextStyle.smallbold(context),
                                ),
                                Text(
                                  truncateWithEllipsis(75, widget.summary),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 100,
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: CachedNetworkImageProvider(widget.imageUrl,
                                  cacheKey: widget.id.toString()),
                              fit: BoxFit.cover,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
