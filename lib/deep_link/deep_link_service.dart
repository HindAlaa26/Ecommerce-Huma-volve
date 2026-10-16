import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

import '../../features/details/screens/product_details_by_id_screen.dart';
import '../navigation/navigator_key.dart';
import 'deep_link_parser.dart';

class DeepLinkService {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _subscription;

  /// A link that arrived before the user reached Home (e.g. cold start
  /// while on Splash / Login). It is opened as soon as Home is ready.
  int? _pendingProductId;
  bool _appReady = false;

  /// Call once in main(). The stream delivers the link that launched the app
  /// (cold start) and every later link.
  void init() {
    _subscription ??= _appLinks.uriLinkStream.listen(_handleUri);
  }

  void _handleUri(Uri uri) {
    final productId = parseProductId(uri);
    if (productId == null) return;

    _pendingProductId = productId;
    _openPendingIfPossible();
  }

  /// Call when the Home screen is built (user is logged in).
  void markAppReady() {
    _appReady = true;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _openPendingIfPossible(),
    );
  }

  void _openPendingIfPossible() {
    final productId = _pendingProductId;
    final navigator = navigatorKey.currentState;
    if (productId == null || !_appReady || navigator == null) return;

    _pendingProductId = null;
    navigator.push(
      MaterialPageRoute(
        builder: (_) => ProductDetailsByIdScreen(productId: productId),
      ),
    );
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}