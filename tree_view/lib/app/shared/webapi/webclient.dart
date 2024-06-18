import 'package:dio/io.dart';

import '../core/core.dart';
import 'interceptors/custom_interceptors.dart';

class WebClient extends DioForNative {
  WebClient() {
    options.baseUrl = BASE_URL;

    options.connectTimeout = const Duration(seconds: 30000);
    options.receiveTimeout = const Duration(seconds: 30000);

    interceptors.add(CustomInterceptors());
  }
}
