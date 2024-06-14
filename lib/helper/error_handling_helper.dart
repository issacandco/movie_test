import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../utils/get_util.dart';
import 'package:dio/dio.dart';

import '../widgets/theme/theme_dialog.dart';

class ErrorHandlingHelper {
  static const String defaultSystemErrorMessage = 'Oops, Something went wrong';

  static void handleError(dynamic error, {bool show = true}) {
    dynamic errorObject;
    if (error is DioException) {
      errorObject = _handleDioError(error);
    } else {
      errorObject = error.toString();
    }

    if (errorObject is Map) {
      if (show) {
        ThemeDialog.show(
          barrierDismissible: false,
          message: errorObject['message'],
          positiveAction: errorObject['isInvalidSession']
              ? () {

                }
              : null,
        );
      } else {
        log(errorObject['message']);
      }
    }

    if (errorObject is String && errorObject.isNotEmpty) {
      if (show) {
        ThemeDialog.show(
          message: errorObject,
        );
      } else {
        log(errorObject);
      }
    }
  }

  static dynamic _handleDioError(DioException dioException) {
    dynamic errorObject;

    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorObject = 'Connection timeout';
        break;
      case DioExceptionType.badCertificate:
        errorObject = 'Bad certificate';
        break;
      case DioExceptionType.badResponse:
        if (dioException.response != null) {
          errorObject = _handleResponseError(dioException.response!.statusCode!, dioException.response!.data);
        } else {
          errorObject = 'Oops.. Something went wrong';
        }
        break;
      case DioExceptionType.cancel:
        errorObject = 'Request cancelled';
        break;
      case DioExceptionType.connectionError:
        errorObject = 'Connection error';
        break;
      case DioExceptionType.unknown:
        errorObject = 'Unknown error';
        break;
      default:
        if (dioException.error is SocketException) {
          errorObject = 'No internet connection';
        } else {
          errorObject = defaultSystemErrorMessage;
        }
        break;
    }
    return errorObject;
  }

  static dynamic _handleResponseError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return getErrorString(error);
      case 401:
        String? message;
        bool isInvalidSession = false;

        try {
          String errorMessage = error['msg'].toString().toLowerCase();

          if (errorMessage.contains('authorization service error') || errorMessage.contains('authorization session not found') || errorMessage.contains('authorization session expired')) {
            message = 'err_invalid_session'.translate();
            isInvalidSession = true;
          } else {
            message = error['msg'];
          }
        } catch (e) {
          log('ErrorHandlingHelper: ${e.toString()}');
          message = defaultSystemErrorMessage;
        }

        return {
          'message': message,
          'isInvalidSession': isInvalidSession,
        };
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 405:
        return 'Method not allowed';
      case 429:
        return 'Too many requests';
      case 431:
        return 'Request Header Fields Too Large';
      case 500:
        return 'Internal server error';
      case 502:
        return statusCode;
      case 503:
        return 'Service unavailable';
      default:
        return defaultSystemErrorMessage;
    }
  }

  static dynamic getErrorString(dynamic error) {
    var errorData = error;
    if (error is String) {
      errorData = jsonDecode(error);
    }
    if (errorData != null) {
      return errorData['msg'];
    } else {
      return errorData.toString();
    }
  }
}
