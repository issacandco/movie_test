import '../api/api_client.dart';
import '../api/network_response.dart';

class MovieRepository {
  MovieRepository._internal();

  static final MovieRepository _singleton = MovieRepository._internal();

  factory MovieRepository() {
    return _singleton;
  }

  Future<NetworkResponse> getMovieGenreList(Map<String, dynamic> request) async {
    return ApiClient.instance.getMovieGenreList(request);
  }

  Future<NetworkResponse> getNowPlayingMovieList(Map<String, dynamic> request) async {
    return ApiClient.instance.getNowPlayingMovieList(request);
  }

  Future<NetworkResponse> getPopularMovieList(Map<String, dynamic> request) async {
    return ApiClient.instance.getPopularMovieList(request);
  }

  Future<NetworkResponse> getTopRatedMovieList(Map<String, dynamic> request) async {
    return ApiClient.instance.getTopRatedMovieList(request);
  }

  Future<NetworkResponse> getUpcomingMovieList(Map<String, dynamic> request) async {
    return ApiClient.instance.getUpcomingMovieList(request);
  }

  Future<NetworkResponse> getMovieDetails(Map<String, dynamic> request) async {
    return ApiClient.instance.getMovieDetails(request);
  }

  Future<NetworkResponse> getMovieTrailerList(Map<String, dynamic> request) async {
    return ApiClient.instance.getMovieTrailerList(request);
  }

  Future<NetworkResponse> searchMovie(Map<String, dynamic> request) async {
    return ApiClient.instance.searchMovie(request);
  }

  Future<NetworkResponse> discoverMovie(Map<String, dynamic> request) async {
    return ApiClient.instance.discoverMovie(request);
  }
}
