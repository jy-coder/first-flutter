import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final url;
  WebViewScreen(this.url);
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final _key = UniqueKey();
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    print(widget.url);
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
                    initialUrl: widget.url))
          ],
        ));
  }
}
