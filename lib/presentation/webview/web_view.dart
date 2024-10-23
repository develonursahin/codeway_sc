import 'dart:async';
import 'dart:developer';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebView {
  final String url;

  WebView({required this.url}) {
    initState();
  }

  final ChromeSafariBrowser browser = MyChromeSafariBrowser();

  late InAppWebViewController inAppWebViewController;

  // Browser options for both platforms
  var options = InAppBrowserClassOptions(
    crossPlatform: InAppBrowserOptions(
      hideUrlBar: false,
    ),
    android: AndroidInAppBrowserOptions(
      hideTitleBar: false,
      allowGoBackWithBackButton: true,
    ),
    inAppWebViewGroupOptions: InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(javaScriptEnabled: true),
    ),
  );

  void initState() {
    init();
  }

  Future<void> init() async {
    Uri parsedUrl = Uri.parse(url);

    // Validate if the URL has an acceptable scheme (http/https)
    if (!['http', 'https'].contains(parsedUrl.scheme)) {
      log('Unsupported URL scheme: ${parsedUrl.scheme}');
      return;
    }

    // Open the URL in a ChromeSafariBrowser
    await browser.open(
      url: WebUri.uri(Uri.parse(url)),
      options: ChromeSafariBrowserClassOptions(
        android: AndroidChromeCustomTabsOptions(shareState: CustomTabsShareState.SHARE_STATE_OFF),
        ios: IOSSafariOptions(barCollapsingEnabled: true),
      ),
    );
  }
}

// Custom ChromeSafariBrowser implementation
class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {}

  @override
  void onCompletedInitialLoad(bool? didLoadSuccessfully) {}

  @override
  void onClosed() {}
}
