import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(this.url, this.title, {Key? key}) : super(key: key);

  final String url;

  final String title;

  @override
  State createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  _DetailPageState();

  Key progressKey = GlobalKey();

  Key contentKey = GlobalKey();

  final WebViewController _controller = WebViewController();

  bool finish = false;

  @override
  void initState() {
    super.initState();
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
          onPageStarted: (url) {},
          onProgress: (progress) {},
          onPageFinished: (content) {
            setState(() {
              finish = true;
            });
          }))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Html(
          data: widget.title,
          style: {
            "html": Style(
                color: Colors.white,
                margin: Margins.zero,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                fontSize: FontSize(18),
                padding: HtmlPaddings.zero,
                alignment: Alignment.topLeft),
            "body": Style(
                color: Colors.white,
                margin: Margins.zero,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                fontSize: FontSize(18),
                padding: HtmlPaddings.zero,
                alignment: Alignment.topLeft)
          },
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: !finish
          ? Container(
              key: progressKey,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: const CircularProgressIndicator())
          : WebViewWidget(key: contentKey, controller: _controller),
    );
  }
}
