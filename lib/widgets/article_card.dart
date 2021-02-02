import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:newheadline/screens/pages/article_screen.dart';
import 'package:newheadline/utils/models.dart';

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

  ArticleCard(this.id, this.title, this.imageUrl, this.summary, this.link,
      this.description, this.pubDate, this.source, this.category);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool showFullSummary = false;

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  @override
  Widget build(BuildContext context) {
    // final _screenSize = MediaQuery.of(context).size;
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 15.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);

    return Container(
      // height: _screenSize.height * 0.4,
      child: Card(
          child: Wrap(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                ArticleScreen.routeName,
                arguments: ScreenArguments(
                  widget.id,
                  widget.title,
                  widget.description,
                  widget.imageUrl,
                  widget.pubDate,
                  widget.source,
                  widget.category,
                ),
              );
              // print(widget.link);
            },
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: 'https://via.placeholder.com/800x500',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
                Column(
                  children: [
                    ListTile(
                      title: Text(widget.title),
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
                  child: RichText(
                    text: TextSpan(
                      style: defaultStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: !showFullSummary
                              ? truncateWithEllipsis(200, widget.summary)
                              : truncateWithEllipsis(1000, widget.summary),
                        ),
                        TextSpan(
                            text: !showFullSummary ? 'Show More' : 'Show Less',
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
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
