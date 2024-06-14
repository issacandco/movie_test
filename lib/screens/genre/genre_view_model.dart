import 'package:get/get.dart';
import 'package:movie_test/base/base_view_model.dart';
import 'package:movie_test/utils/constant_util.dart';
import 'package:movie_test/utils/get_storage_util.dart';

import '../../models/genre_model.dart';

class GenreViewModel extends BaseViewModel {
  RxList<GenreModel> genreListStream = <GenreModel>[].obs;
  RxList<GenreModel> selectedGenresStream = <GenreModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    List<GenreModel> genreList = GetStorageUtil.readFromGetStorage<List<GenreModel>>(key: ConstantUtil.keyGenres) ?? [];
    genreListStream.value = genreList;
  }

  void onSelectGenre(GenreModel genre) {
    if (selectedGenresStream.contains(genre)) {
      selectedGenresStream.remove(genre);
    } else {
      selectedGenresStream.add(genre);
    }
  }

  bool isSelected(GenreModel genre) {
    return selectedGenresStream.contains(genre);
  }
}
