import 'package:dio/dio.dart';

import '../../core/core.dart';

class CustomInterceptors extends Interceptor {
  final AppLog _appLog = AppLog();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logRequest(options);
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    _logResponse(response);
    return super.onResponse(response, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) async {
    _logError(err);

    return super.onError(err, handler);
  }

  void _logRequest(RequestOptions options) {
    assert(() {
      _appLog.printAll(
        "=====BEGIN REQUEST======",
      );

      var msg = "METHOD -> ${options.method}";
      msg += "\nHEADERS -> ${options.headers}";
      msg += "\nURL -> ${options.baseUrl}${options.path}";
      msg += "\nDATA -> ${_formatData(options.data)}";
      _appLog.printAll(
        msg,
      );

      _appLog.printAll(
        "=====END REQUEST======",
      );

      return true;
    }());
  }

  void _logResponse(Response response) {
    assert(() {
      _appLog.printAll("=====BEGIN RESPONSE======");
      _appLog.printAll(
        "REQUEST METHOD -> ${response.requestOptions.method}",
      );
      _appLog.printAll(
        "REQUEST HEADERS -> ${response.requestOptions.headers}",
      );
      _appLog.printAll(
        "REQUEST URL -> ${response.requestOptions.baseUrl}${response.requestOptions.path}",
      );
      _appLog.printAll(
        "REQUEST DATA -> ${_formatData(response.requestOptions.data)}",
      );
      _appLog.printAll("===========");
      _appLog.printAll(
        "RESPONSE CODE -> ${response.statusCode}",
      );
      _appLog.printAll(
        "RESPONSE HEADERS -> ${response.headers}",
      );
      _appLog.printAll("RESPONSE BODY -> $response");
      _appLog.printAll("=====END RESPONSE======");

      return true;
    }());
  }

  void _logError(DioException err) {
    assert(() {
      _appLog.printAll("=====BEGIN ERROR======");
      _appLog.printAll("REQUEST METHOD -> ${err.requestOptions.method}");
      _appLog.printAll("REQUEST HEADERS -> ${err.requestOptions.headers}");
      _appLog.printAll(
          "REQUEST URL -> ${err.requestOptions.baseUrl}${err.requestOptions.path}");
      _appLog
          .printAll("REQUEST DATA -> ${_formatData(err.requestOptions.data)}");
      _appLog.printAll("===========");
      _appLog.printAll("RESPONSE CODE -> ${err.response?.statusCode}");
      _appLog.printAll("RESPONSE HEADERS -> ${err.response?.headers}");
      _appLog.printAll("RESPONSE BODY -> ${err.response}");
      _appLog.printAll("=====END ERRO======");

      return true;
    }());
  }

  static dynamic _formatData(dynamic data) {
    if (data == null) return data;

    final type = data.runtimeType.toString();
    try {
      if (type.startsWith('List')) {
        return data.map((e) => e.toJson()).toList();
      } else if (type.startsWith('Map')) {
        return data;
      } else {
        return data.json();
      }
    } catch (_) {
      return data;
    }
  }
}
