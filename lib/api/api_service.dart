import 'package:dio/dio.dart';

import 'api_service_util.dart';
import 'network_response.dart';

class ApiService {
  final Dio _dio;
  String? baseUrl;

  final String version_3 = '3';

  ApiService(this._dio, {this.baseUrl});

  ApiServiceUtil get apiServiceUtil => ApiServiceUtil(_dio, baseUrl: baseUrl);

  Future<NetworkResponse> getMovieGenreList(Map<String, dynamic> queryRequest) {
    return apiServiceUtil.request(RequestType.get, '/$version_3/genre/movie/list', queryParameters: queryRequest);
  }

  Future<NetworkResponse> getNowPlayingMovieList(Map<String, dynamic> queryRequest) {
    return apiServiceUtil.request(RequestType.get, '/$version_3/movie/now_playing', queryParameters: queryRequest);
  }

  Future<NetworkResponse> getPopularMovieList(Map<String, dynamic> queryRequest) {
    return apiServiceUtil.request(RequestType.get, '/$version_3/movie/popular', queryParameters: queryRequest);
  }

  Future<NetworkResponse> getTopRatedMovieList(Map<String, dynamic> queryRequest) {
    return apiServiceUtil.request(RequestType.get, '/$version_3/movie/top_rated', queryParameters: queryRequest);
  }

  Future<NetworkResponse> getUpcomingMovieList(Map<String, dynamic> queryRequest) {
    return apiServiceUtil.request(RequestType.get, '/$version_3/movie/upcoming', queryParameters: queryRequest);
  }

  Future<NetworkResponse> getMovieDetails(Map<String, dynamic> request) {
    return apiServiceUtil.request(RequestType.get, '/$version_3/movie/:movieId', pathParams: request);
  }

  Future<NetworkResponse> getMovieTrailerList(Map<String, dynamic> request) {
    return apiServiceUtil.request(RequestType.get, '/$version_3/movie/:movieId/videos', pathParams: request);
  }

  Future<NetworkResponse> searchMovie(Map<String, dynamic> request) {
    return apiServiceUtil.request(RequestType.get, '/$version_3/search/movie', queryParameters: request);
  }

  Future<NetworkResponse> discoverMovie(Map<String, dynamic> request) {
    return apiServiceUtil.request(RequestType.get, '/$version_3/discover/movie', queryParameters: request);
  }
}
