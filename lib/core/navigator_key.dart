import 'package:flutter/material.dart';

/// Global key so we can navigate without a BuildContext (deep links).
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();