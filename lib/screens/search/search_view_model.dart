import 'package:get/get.dart';
import 'package:movie_test/base/base_view_model.dart';
import 'package:movie_test/repositories/movie_repository.dart';
import 'package:movie_test/utils/constant_util.dart';
import 'package:movie_test/utils/get_storage_util.dart';

import '../../models/genre_model.dart';
import '../../models/movie_model.dart';

class SearchViewModel extends BaseViewModel {
  RxString searchTextStream = ''.obs;
  RxList<MovieModel> movieListStream = <MovieModel>[].obs;
  RxList<GenreModel> selectedGenreListStream = <GenreModel>[].obs;

  final MovieRepository _movieRepository = MovieRepository();

  setSearchText(value) {
    searchTextStream.value = value;
  }

  setGenreList(List<GenreModel> value) {
    selectedGenreListStream.value = value;
  }

  void onSearch({required String query, bool isFromRecentSearch = false}) async {
    try {
      initialLoading();

      final request = {
        'query': query,
      };

      final response = await _movieRepository.searchMovie(request);

      if (!isFromRecentSearch) {
        insertRecentSearch(query);
      }

      response.when(
        success: (data) {
          movieListStream.value = (data['results'] as List).map((e) => MovieModel.fromJson(e as Map<String, dynamic>)).toList();
          print(movieListStream.length);
        },
        error: (e) {
          handleError(e);
        },
      );
    } catch (e) {
      handleError(e);
    } finally {
      doneResponse();
    }
  }

  void onDiscoverMovie() async {
    try {
      initialLoading();
      final request = {
        'with_genres': selectedGenreListStream.map((e) => e.id).toList().join('|'),
        'sort_by': 'release_date.desc',
      };

      final response = await _movieRepository.discoverMovie(request);

      response.when(
        success: (data) {
          movieListStream.value = (data['results'] as List).map((e) => MovieModel.fromJson(e as Map<String, dynamic>)).toList();
          print(movieListStream.length);
        },
        error: (e) {
          handleError(e);
        },
      );
    } catch (e) {
      handleError(e);
    } finally {
      doneResponse();
    }
  }

  void insertRecentSearch(String query) {
    List<dynamic> recentSearchList = GetStorageUtil.readFromGetStorage(key: ConstantUtil.keyRecentSearch) ?? [];
    recentSearchList.add(query);
    GetStorageUtil.saveIntoGetStorage(key: ConstantUtil.keyRecentSearch, value: recentSearchList);
  }
}
