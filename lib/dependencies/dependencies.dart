import 'package:get/get.dart';

import '../app/app_view_model.dart';
import '../utils/get_util.dart';

class Dependencies implements Bindings {
  @override
  void dependencies() {
    GetUtil.lazyPut<AppViewModel>(() => AppViewModel());
  }
}
