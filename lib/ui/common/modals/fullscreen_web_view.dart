import 'package:webview_flutter/webview_flutter.dart';
import 'package:wondrous_opentelemetry/common_libs.dart';

class FullscreenWebView extends StatelessWidget {
  FullscreenWebView(this.url, {super.key});
  final String url;

  late final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..loadRequest(Uri.parse(url));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
