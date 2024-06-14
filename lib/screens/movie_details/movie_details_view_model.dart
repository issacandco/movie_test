import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:movie_test/base/base_view_model.dart';
import 'package:movie_test/repositories/movie_repository.dart';

import '../../models/movie_model.dart';

class MovieDetailsViewModel extends BaseViewModel {
  final MovieRepository _movieRepository = MovieRepository();

  Rx<MovieModel> movieDetailsStream = MovieModel().obs;
  RxString movieTrailerKeyStream = ''.obs;

  void getMovieDetailsAndTrailer(int movieId) async {
    print(movieId);

    try {
      initialLoading();

      final request = {
        'movieId': movieId,
      };

      final detailsResponse = await _movieRepository.getMovieDetails(request);
      final trailerResponse = await _movieRepository.getMovieTrailerList(request);

      detailsResponse.when(
        success: (data) {
          movieDetailsStream.value = MovieModel.fromJson(data);
        },
        error: (e) {
          handleError(e);
        },
      );
      trailerResponse.when(
        success: (data) {
          List videos = data['results'];
          for (var video in videos) {
            if (video['type'] == 'Trailer' && video['site'] == 'YouTube') {
              movieTrailerKeyStream.value = video['key'];
            }
          }
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
