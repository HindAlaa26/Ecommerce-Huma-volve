const String kDeepLinkScheme = 'humavolve';

/// Supported links:
///   humavolve://product/5
///   https://<your-domain>/product/5   (when you add App Links later)
/// Returns the product id, or null if the link is not a product link.
int? parseProductId(Uri uri) {
  final segments = uri.scheme == kDeepLinkScheme
      ? <String>[uri.host, ...uri.pathSegments]
      : uri.pathSegments;

  if (segments.length >= 2 && segments[0] == 'product') {
    return int.tryParse(segments[1]);
  }
  return null;
}

String buildProductLink(int productId) => '$kDeepLinkScheme://product/$productId';