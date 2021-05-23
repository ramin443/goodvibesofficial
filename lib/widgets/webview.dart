import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:goodvibesoffl/widgets/common_widgets/appBar.dart';
import 'package:goodvibesoffl/widgets/common_widgets/pages_wrapper_with_background.dart';

class WebViewBody extends StatelessWidget {
  final String url;

  WebViewBody({this.url});
  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: url,
      withJavascript: true,
      hidden: true,
      withLocalStorage: true,
      initialChild: Container(
        child: new Center(
          child: new Container(
            margin: const EdgeInsets.all(20),
            child: CupertinoActivityIndicator(),
          ),
        ),
      ),
    );
  }
}

class WebView extends StatelessWidget {
  final appbarTitle;
  final url;

  WebView({this.appbarTitle, this.url});

  Widget build(BuildContext context) {
    return PagesWrapperWithBackground(
      customPaddingHoz: 0.0,
      hasScaffold: true,
      appbar: customAppBar(
        context: context,
        title: appbarTitle,
        backButton: true,
      ),
      // child: Scaffold(
      //   backgroundColor: Colors.transparent,
      //   body: NestedScrollView(
      //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      //       return <Widget>[
      //         SliverAppBar(
      //           // leading: Container(),
      //           backgroundColor: Colors.transparent,
      //           floating: false,
      //           pinned: true,
      //           automaticallyImplyLeading: false,
      //           leading: IconButton(
      //             icon: Icon(
      //               BackIcon.back,
      //               size: getFontSize(context, 2.1),
      //             ),
      //             onPressed: () => Navigator.of(context).pop(),
      //           ),
      //           forceElevated: false,
      //           flexibleSpace: Container(
      //             width: double.infinity,
      //             // height: 160.0,
      //             child: Align(
      //               alignment: Alignment.bottomCenter,
      //               child: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Text(
      //                   appbarTitle,
      //                   style: Theme.of(context).textTheme.button.copyWith(
      //                         color: Colors.white,
      //                       ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ];
      //     },
      child: WebViewBody(url: url),
      // ),
      // ),
    );
  }
}
