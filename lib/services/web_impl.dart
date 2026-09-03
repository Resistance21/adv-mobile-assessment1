import 'package:web/web.dart' as web;

bool isWebOffline() => web.window.navigator.onLine == false;
