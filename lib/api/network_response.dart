import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_response.freezed.dart';

@freezed
class NetworkResponse with _$NetworkResponse {
  const factory NetworkResponse.success(Map<String, dynamic> data) = SUCCESS;
  const factory NetworkResponse.error(dynamic error)= ERROR;
}