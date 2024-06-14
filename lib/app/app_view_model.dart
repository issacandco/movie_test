// import '../api/network_response.dart';
// import '../base/base_view_model.dart';
// import '../models/base_response_model.dart';
// import '../models/constant_model.dart';
// import '../models/server_config_model.dart';
// import '../repositories/server_config_repository.dart';
// import '../utilities/constant_util.dart';
// import '../utilities/get_storage_util.dart';
//
import '../base/base_view_model.dart';

class AppViewModel extends BaseViewModel {
//   final ServerConfigRepository _serverConfigRepository = ServerConfigRepository();
//
//   static const int codeCheckVersion = 1;
//   static const int codeGetServerConfig = 2;
//
//   void checkVersion({required String deviceType, required Map<String, String> packageInfo}) async {
//     try {
//       NetworkResponse response = await _serverConfigRepository.checkVersion();
//
//       response.when(
//         success: (data) {
//           BaseResponseModel<ServerConfigModel> baseResponse = BaseResponseModel.fromJson(
//             data,
//             (json) => ServerConfigModel.fromJson(json as Map<String, dynamic>),
//           );
//           if (baseResponse.isSuccess) {
//             onResponse(null, typeCode: codeCheckVersion);
//           }
//         },
//         error: (error) => handleError(error),
//       );
//     } catch (e) {
//       handleError(e);
//     } finally {
//       doneResponse();
//     }
//   }
//
//   void getServerConfig() async {
//     try {
//       final request = {
//         'type': ServerConfigType.constant.name,
//       };
//
//       NetworkResponse response = await _serverConfigRepository.getServerConfig(request);
//
//       response.when(
//         success: (data) {
//           BaseResponseModel<ServerConfigModel> baseResponse = BaseResponseModel.fromJson(data, (json) => ServerConfigModel.fromJson(json as Map<String, dynamic>));
//
//           if (baseResponse.isSuccess) {
//             ServerConfigModel serverConfigModel = baseResponse.data!;
//             ConstantModel constantModel = serverConfigModel.data!;
//             GetStorageUtil.saveIntoGetStorage(key: ConstantUtil.keyConstant, value: constantModel);
//
//             onResponse(null, typeCode: codeGetServerConfig);
//           }
//         },
//         error: (error) => handleError(error),
//       );
//     } catch (e) {
//       handleError(e);
//     } finally {
//       doneResponse();
//     }
//   }
}
