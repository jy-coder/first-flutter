import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final _key = UniqueKey();
  final String url;
  WebViewScreen(this.url);
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: WebView(
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                  },
                  // navigationDelegate: (NavigationRequest request) {
                  //   return NavigationDecision.prevent;
                  // },
                  initialUrl: this.url),
            )
          ],
        ));
  }
}
