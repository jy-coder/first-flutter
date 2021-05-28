import 'package:flutter/material.dart';
import 'package:newheadline/models/models.dart';
import 'package:newheadline/provider/article.dart';
import 'package:newheadline/provider/theme.dart';
import 'package:newheadline/screens/single_article/webview_screen.dart';
import 'package:newheadline/shared/textstyle.dart';
import 'package:newheadline/utils/common.dart';
import 'package:newheadline/utils/response.dart';
import 'package:newheadline/utils/urls.dart';
import 'package:newheadline/widgets/bookmark_button.dart';
import 'package:newheadline/widgets/like_button.dart';
import 'package:newheadline/widgets/share_button.dart';
import 'package:newheadline/widgets/theme_button.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ScreenArguments {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String pubDate;
  final String source;
  final String category;
  final String link;

  ScreenArguments(
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.pubDate,
    this.source,
    this.category,
    this.link,
  );
}

class RelatedScreen extends StatefulWidget {
  final ScreenArguments settings;
  RelatedScreen(this.settings);

  static final routeName = "related-screen";

  @override
  _RelatedScreenState createState() => _RelatedScreenState();
}

Future<void> saveReadingHistory(int articleId) async {
  String url = "$HISTORY_URL/?article=$articleId";
  var result = await APIService().post(url);
}

class _RelatedScreenState extends State<RelatedScreen> {
  List<Article> relatedArticles = [];
  ScrollController _scrollController;
  bool _isVisible = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent) {
            saveReadingHistory(widget.settings.id);
            _isVisible = true;
          } else {
            _isVisible = false;
          }
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider tProvider = Provider.of<ThemeProvider>(context, listen: true);
    ArticleProvider aProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    String timeAgo = formatDate(widget.settings.pubDate);
    return Scaffold(
        appBar: AppBar(actions: [
          Container(
            child: Row(
              children: [
                LikeBtn(widget.settings.id),
                BookmarkBtn(widget.settings.id),
                ShareBtn(link: widget.settings.link),
                CustomizeThemeButton(),
              ],
            ),
          )
        ]),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            child: Wrap(
              children: [
                Container(
                    height: 300,
                    width: 500,
                    child: Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: widget.settings.imageUrl,
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
                      SelectableText(
                        widget.settings.title,
                        style:
                            CustomTextStyle.title1(context, tProvider.fontSize),
                        textAlign: TextAlign.center,
                        toolbarOptions: ToolbarOptions(copy: true),
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
                                  Text(
                                    widget.settings.source,
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
                        child: SelectableText(
                          widget.settings.description,
                          toolbarOptions: ToolbarOptions(copy: true),
                          style: CustomTextStyle.normal(
                            context,
                            tProvider.fontSize,
                          ),
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
                                        WebViewScreen(widget.settings.link)));
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: _isVisible
            ? MaterialButton(
                onPressed: () {
                  _scrollToTop();
                },
                color: tProvider.theme == "dark" ? Colors.white : Colors.black,
                textColor:
                    tProvider.theme == "dark" ? Colors.black : Colors.white,
                child: Icon(
                  Icons.arrow_upward,
                  size: 20,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              )
            : null);
  }
}
