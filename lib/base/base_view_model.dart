import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/error_handling_helper.dart';
import '../models/base_response_model.dart';

enum ConnectionStateType { none, loading, active, done }

typedef OnLoadingResponse = void Function();
typedef OnSuccessResponse = void Function(int, dynamic);
typedef OnErrorResponse = void Function(int, String);
typedef OnDoneResponse = void Function();
typedef BaseResponseBuilder<S> = S Function(Object?);

abstract class BaseViewModel<T> extends GetxController with StateMixin {
  Rx<BaseResponseModel> baseResponseStream = BaseResponseModel().obs;

  int _threadNumber = 1;

  Rx<ConnectionStateType> connectionStateTypeStream = ConnectionStateType.none.obs;
  OnLoadingResponse? _onLoadingResponse;
  OnSuccessResponse? _onSuccessResponse;
  OnErrorResponse? _onErrorResponse;
  OnDoneResponse? _onDoneResponse;

  void initialLoading() {
    _onLoadingResponse?.call();
    connectionStateTypeStream.value = ConnectionStateType.loading;
  }

  void doneResponse() {
    _onDoneResponse?.call();
    connectionStateTypeStream.value = ConnectionStateType.done;
  }

  void onResponse(dynamic responseData, {int? typeCode}) {
    _onSuccessResponse?.call(typeCode ?? _threadNumber++, responseData);
    connectionStateTypeStream.value = ConnectionStateType.active;
  }

  void handleError(dynamic error, {bool show = true}) {
    ErrorHandlingHelper.handleError(error, show: show);
  }

  BaseResponseModel<U>? handleGenericResponse<U>(String response, {BaseResponseBuilder<U>? builder, int? typeCode}) {
    try {
      Map<String, dynamic> jsonMap = jsonDecode(response);
      BaseResponseModel<U> baseResponseModel = BaseResponseModel<U>.fromJson(jsonMap, builder ?? (json) => null as U);
      if (baseResponseModel.isSuccess && builder == null) {
        onResponse(jsonMap['data'], typeCode: typeCode);
      } else if (baseResponseModel.isSuccess && builder != null) {
        onResponse(baseResponseModel, typeCode: typeCode);
      }
      return baseResponseModel;
    } catch (e) {
      debugPrint(e.toString());
      _onErrorResponse?.call(101, e.toString());
      return null;
    }
  }

  void addResponseListener({
    OnLoadingResponse? onLoadingResponse,
    OnSuccessResponse? onSuccessResponse,
    OnErrorResponse? onErrorResponse,
    OnDoneResponse? onDoneResponse,
  }) {
    _onLoadingResponse = onLoadingResponse;
    _onSuccessResponse = onSuccessResponse;
    _onErrorResponse = onErrorResponse;
    _onDoneResponse = onDoneResponse;
  }
}
