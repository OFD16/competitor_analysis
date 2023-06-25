import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewMobileScreen extends StatefulWidget {
  const WebViewMobileScreen({super.key});

  @override
  State<WebViewMobileScreen> createState() => _WebViewMobileScreenState();
}

const url =
    'https://www.etsy.com/listing/1254272533/adhd-notion-life-planner-adhd-notion?click_key=08ef9c9b225bfc7c93acc3ef031fe58aaf24d25a%3A1254272533&click_sum=7c28f55d&ref=shop_home_feat_2&pro=1&sts=1';

class _WebViewMobileScreenState extends State<WebViewMobileScreen> {
  @override
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // ..addJavaScriptChannel(
    //   'Print',
    //   onMessageReceived: (message) {
    //     print(message.message);
    //   },
    // )
    // ..runJavaScriptReturningResult(javaScript)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},

        onPageFinished: (String url) async {
          // if (url.contains('/recon?')) {
          //               // if JavaScript is enabled, you can use
          //               var html = await controller.evaluateJavascript();

          //                   print("------------------------------------------------------");
          //               print(html);
          //               print("------------------------------------------------------")
        },
        // onLoadStop: (InAppWebViewController controller, String url) async {
        //               if (url.contains('/recon?')) {
        //                 // if JavaScript is enabled, you can use
        //                 var html = await controller.evaluateJavascript(
        //                     source: "window.document.getElementsByTagName('html')[0].outerHTML;");

        //                 log(html);
        //               }
        //             },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith(url)) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(url));
  Widget build(BuildContext context) {
    print("------------------------------------------------------");
    // print('controller:  ${controller.evaluateJavascript}');
    // print('controller: ${controller.addJavaScriptChannel(
    //   'name',
    //   onMessageReceived: (message) {
    //     print(message.message);
    //   },
    // )}');
    print("------------------------------------------------------");
    return WebViewWidget(controller: controller);
  }
}
