import 'package:get_storage/get_storage.dart';

import 'constant_util.dart';

typedef StorageBuilder<S> = S Function(Map<String, dynamic> storageData);

class GetStorageUtil {
  GetStorageUtil._();

  static Future<bool> initGetStorage([String containerName = ConstantUtil.appName]) {
    return GetStorage.init(containerName);
  }

  static Future<void> saveIntoGetStorage({required String key, dynamic value, String? containerName}) {
    return GetStorage(containerName ?? ConstantUtil.appName).write(key, value);
  }

  static T? readFromGetStorage<T>({required String key, String? containerName}) {
    return GetStorage(containerName ?? ConstantUtil.appName).read<T>(key);
  }

  static Future<void> removeByKey({required String key, String? containerName}) {
    return GetStorage(containerName ?? ConstantUtil.appName).remove(key);
  }

  static Future<void> eraseGetStorage({String? containerName}) {
    return GetStorage(containerName ?? ConstantUtil.appName).erase();
  }

  /// Get storage data is Map<String, dynamic>, cannot directly convert Map to Model (Object)
  /// This function is to prevent '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type {}
  /// NOTE: If no key found, this function will return null
  static T? getStorageDataByKey<T>(String key, StorageBuilder<T> builder, {String? containerName}) {
    var storageData = readFromGetStorage(
      key: key,
      containerName: containerName,
    );
    return storageData != null
        ? storageData is T
            ? storageData
            : storageData is Map<String, dynamic>
                ? builder.call(storageData)
                : storageData
        : null;
  }
}
