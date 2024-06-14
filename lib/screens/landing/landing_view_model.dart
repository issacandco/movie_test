import 'package:get/get.dart';
import 'package:movie_test/base/base_view_model.dart';
import 'package:movie_test/models/genre_model.dart';
import 'package:movie_test/models/movie_model.dart';
import 'package:movie_test/repositories/movie_repository.dart';
import 'package:movie_test/utils/constant_util.dart';
import 'package:movie_test/utils/get_storage_util.dart';
import 'package:movie_test/utils/get_util.dart';

enum MovieCategory {
  nowPlaying,
  popular,
  topRated,
  upcoming,
}

class LandingViewModel extends BaseViewModel {
  RxList<Map<String, dynamic>> categoryListStream = <Map<String, dynamic>>[].obs;
  RxMap<String, dynamic> selectedCategoryStream = <String, dynamic>{}.obs;
  RxList<MovieModel> movieListStream = <MovieModel>[].obs;

  final MovieRepository _movieRepository = MovieRepository();

  int currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    categoryListStream.value = [
      {'categoryName': 'now_playing'.translate(), 'categoryKey': MovieCategory.nowPlaying},
      {'categoryName': 'popular'.translate(), 'categoryKey': MovieCategory.popular},
      {'categoryName': 'top_rated'.translate(), 'categoryKey': MovieCategory.topRated},
      {'categoryName': 'upcoming'.translate(), 'categoryKey': MovieCategory.upcoming},
    ];

    getMovieGenreList();

    getNowPlayingMovieList();

    selectedCategoryStream.value = categoryListStream.first;
  }

  void getMovieGenreList() async {
    try {
      initialLoading();

      final request = {'language': 'en'};
      final response = await _movieRepository.getMovieGenreList(request);

      response.when(
        success: (data) {
          List<GenreModel> genreList = (data['genres'] as List).map((e) => GenreModel.fromJson(e as Map<String, dynamic>)).toList();
          GetStorageUtil.saveIntoGetStorage(key: ConstantUtil.keyGenres, value: genreList);
        },
        error: (e) {
          handleError(e);
        },
      );
    } catch (e) {
      handleError(e);
    }
  }

  void onCategorySelected(Map<String, dynamic> value) {
    selectedCategoryStream.value = value;
    currentPage = 1;

    switch (value['categoryKey']) {
      case MovieCategory.nowPlaying:
        getNowPlayingMovieList();
        break;
      case MovieCategory.popular:
        getPopularMovieList();
        break;
      case MovieCategory.topRated:
        getTopRatedMovieList();
        break;
      case MovieCategory.upcoming:
        getUpcomingMovieList();
        break;
    }
  }

  void getNowPlayingMovieList() async {
    try {
      initialLoading();

      final request = {
        'language': 'en-US',
        'page': currentPage,
        'sort_by': 'release_date.desc',
      };

      final response = await _movieRepository.getNowPlayingMovieList(request);

      response.when(
        success: (data) {
          final totalPage = data['total_pages'] as int;

          List<MovieModel> movieList = (data['results'] as List).map((e) => MovieModel.fromJson(e as Map<String, dynamic>)).toList();
          print(totalPage);
          movieListStream.value = movieList;
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

  void getPopularMovieList() async {
    try {
      initialLoading();

      final request = {
        'language': 'en-US',
        'page': currentPage,
        'sort_by': 'release_date.desc',
      };

      final response = await _movieRepository.getPopularMovieList(request);

      response.when(
        success: (data) {
          final totalPage = data['total_pages'] as int;

          List<MovieModel> movieList = (data['results'] as List).map((e) => MovieModel.fromJson(e as Map<String, dynamic>)).toList();
          print(totalPage);
          movieListStream.value = movieList;
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

  void getTopRatedMovieList() async {
    try {
      initialLoading();

      final request = {
        'language': 'en-US',
        'page': currentPage,
        'sort_by': 'release_date.desc',
      };

      final response = await _movieRepository.getTopRatedMovieList(request);

      response.when(
        success: (data) {
          final totalPage = data['total_pages'] as int;

          List<MovieModel> movieList = (data['results'] as List).map((e) => MovieModel.fromJson(e as Map<String, dynamic>)).toList();
          print(totalPage);
          movieListStream.value = movieList;
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

  void getUpcomingMovieList() async {
    try {
      initialLoading();

      final request = {
        'language': 'en-US',
        'page': currentPage,
        'sort_by': 'release_date.desc',
      };

      final response = await _movieRepository.getUpcomingMovieList(request);

      response.when(
        success: (data) {
          final totalPage = data['total_pages'] as int;

          List<MovieModel> movieList = (data['results'] as List).map((e) => MovieModel.fromJson(e as Map<String, dynamic>)).toList();
          print(totalPage);
          movieListStream.value = movieList;
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
}
