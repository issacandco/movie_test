import 'package:dio/dio.dart';

import 'network_response.dart';

enum RequestType { get, post, put, patch, delete }

class ApiServiceUtil {
  final Dio _dio;
  String? baseUrl;

  ApiServiceUtil(
    this._dio, {
    this.baseUrl,
  });

  Future<NetworkResponse> request(
    RequestType requestType,
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParams,
    Options? options,
  }) async {
    late Response? result;

    try {
      switch (requestType) {
        case RequestType.get:
          result = await _dio.get(
            _buildPath(path, pathParams),
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case RequestType.post:
          result = await _dio.post(
            _buildPath(path, pathParams),
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case RequestType.put:
          result = await _dio.put(
            _buildPath(path, pathParams),
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case RequestType.patch:
          result = await _dio.patch(
            _buildPath(path, pathParams),
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case RequestType.delete:
          result = await _dio.delete(
            _buildPath(path, pathParams),
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
          break;
      }

      return NetworkResponse.success(result.data);
    } catch (e) {
      return NetworkResponse.error(e);
    }
  }

  String _buildPath(String path, Map<String, dynamic>? pathParams) {
    if (pathParams != null) {
      pathParams.forEach((key, value) {
        path = path.replaceAll(':$key', value.toString());
      });
    }
    return _combineBaseUrls(baseUrl) + path;
  }

  String _combineBaseUrls(String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return _dio.options.baseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(_dio.options.baseUrl).resolveUri(url).toString();
  }
}
