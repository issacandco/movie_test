import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:movie_test/base/base_view_model.dart';
import 'package:movie_test/utils/get_storage_util.dart';

import '../../utils/constant_util.dart';

class RecentSearchViewModel extends BaseViewModel {
  RxList<String> recentSearchListStream = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    List<dynamic> dynamicRecentSearchList = GetStorageUtil.readFromGetStorage(key: ConstantUtil.keyRecentSearch) ?? [];

    List<String> recentSearchList = dynamicRecentSearchList.map((e) => e.toString()).toList();
    print(recentSearchList);
    recentSearchListStream.value = recentSearchList;
  }

  onClearRecentSearch() {
    GetStorageUtil.removeByKey(key: ConstantUtil.keyRecentSearch);
    recentSearchListStream.value = [];
  }
}
