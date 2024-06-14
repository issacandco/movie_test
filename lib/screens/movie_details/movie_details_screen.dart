import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_test/extensions/date_time_extension.dart';
import 'package:movie_test/models/movie_model.dart';
import 'package:movie_test/screens/movie_details/youtube_video_player.dart';
import 'package:movie_test/styles/app_size.dart';
import 'package:movie_test/styles/app_text_style.dart';

import '../../base/base_page.dart';
import '../../styles/app_color.dart';
import '../../utils/get_util.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/theme/theme_shimmer.dart';
import 'movie_details_view_model.dart';

class MovieDetailsScreen extends BasePage {
  const MovieDetailsScreen({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends BaseState<MovieDetailsScreen> with BasicPage {
  final MovieDetailsViewModel _movieDetailsViewModel = GetUtil.put(MovieDetailsViewModel());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _movieDetailsViewModel.getMovieDetailsAndTrailer(widget.movieId);
    });

    _movieDetailsViewModel.addResponseListener(
      onLoadingResponse: () {
        LoadingWidget.showLoading(context);
      },
      onDoneResponse: () {
        LoadingWidget.dismissLoading();
      },
      onSuccessResponse: (typeCode, data) {},
    );
  }

  @override
  Widget body() {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                GetUtil.getX<MovieDetailsViewModel>(
                  builder: (vm) {
                    String movieTrailerKey = vm.movieTrailerKeyStream.value;
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        YouTubeVideoPlayer(videoId: movieTrailerKey),
                        Positioned(
                          bottom: AppSize.size_16,
                          child: Opacity(
                            opacity: movieTrailerKey.isEmpty ? 1.0 : 0.0,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: AppSize.size_16, vertical: AppSize.size_8),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(AppSize.size_8),
                              ),
                              child: Text(
                                'no_trailer'.translate(),
                                style: AppTextStyle.customTextStyle(color: AppColor.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.all(AppSize.standardSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildPoster(),
                          SizedBox(width: AppSize.size_16),
                          _buildMovieBasicInfo(),
                        ],
                      ),
                      SizedBox(height: AppSize.size_24),
                      _buildGenres(),
                      SizedBox(height: AppSize.size_16),
                      _buildOverview(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: AppSize.size_16,
            left: AppSize.size_8,
            child: InkWell(
              onTap: () {
                GetUtil.back();
              },
              child: CircleAvatar(
                backgroundColor: AppColor.primaryColor.withOpacity(0.7),
                radius: AppSize.size_24,
                child: const Icon(Icons.arrow_back, color: AppColor.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoster() => Container(
        child: GetUtil.getX<MovieDetailsViewModel>(
          builder: (vm) {
            MovieModel movieModel = vm.movieDetailsStream.value;

            return movieModel.poster != null && movieModel.poster!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.size_16),
                    child: CachedNetworkImage(
                      imageUrl: movieModel.poster ?? '',
                      width: AppSize.getScreenWidth(percent: 30),
                      height: AppSize.getScreenHeight(percent: 20),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => ThemeShimmer.rectangular(
                        width: AppSize.getScreenWidth(percent: 30),
                        height: AppSize.getScreenHeight(percent: 20),
                      ),
                      errorWidget: (context, url, error) => const SizedBox.shrink(),
                    ),
                  )
                : SizedBox(
                    width: AppSize.getScreenWidth(percent: 30),
                    height: AppSize.getScreenHeight(percent: 18),
                    child: Center(
                      child: Text(
                        'no_poster'.translate(),
                        style: AppTextStyle.customTextStyle(),
                      ),
                    ),
                  );
          },
        ),
      );

  Widget _buildMovieBasicInfo() => Flexible(
        child: GetUtil.getX<MovieDetailsViewModel>(
          builder: (vm) {
            MovieModel movieModel = vm.movieDetailsStream.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movieModel.title ?? '',
                  style: AppTextStyle.customTextStyle(
                    fontSize: AppSize.textSize_20,
                    fontWeightType: FontWeightType.bold,
                  ),
                ),
                SizedBox(height: AppSize.size_4),
                Row(
                  children: [
                    RatingBar.builder(
                      ignoreGestures: true,
                      initialRating: double.parse(movieModel.voteAverage != null ? movieModel.voteAverage!.toStringAsPrecision(2) : '0.00') / 2,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: AppSize.size_20,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      unratedColor: AppColor.gray,
                      onRatingUpdate: (rating) {},
                    ),
                    SizedBox(width: AppSize.size_8),
                    Text(
                      '${movieModel.voteAverage?.toStringAsPrecision(2) ?? 0.0}/10',
                      style: AppTextStyle.customTextStyle(
                        fontSize: AppSize.textSize_16,
                        fontWeightType: FontWeightType.medium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.size_4),
                Row(
                  children: [
                    const Icon(CupertinoIcons.calendar),
                    SizedBox(width: AppSize.size_8),
                    Text(
                      movieModel.releaseDate != null && movieModel.releaseDate!.isNotEmpty ? movieModel.releaseDate.toString().parseStringToDateTimeString(format: 'dd-MMM-yyyy') : 'no_release_date'.translate(),
                      style: AppTextStyle.customTextStyle(
                        fontSize: AppSize.textSize_16,
                        fontWeightType: FontWeightType.regular,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );

  Widget _buildGenres() => GetUtil.getX<MovieDetailsViewModel>(
        builder: (vm) {
          MovieModel movieModel = vm.movieDetailsStream.value;

          return Wrap(
            spacing: AppSize.size_8,
            runSpacing: AppSize.size_8,
            children: movieModel.genres?.map((e) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.size_16, vertical: AppSize.size_8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.size_8),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Text(
                      e['name'] ?? '',
                      style: AppTextStyle.customTextStyle(
                        fontSize: AppSize.textSize_14,
                        fontWeightType: FontWeightType.medium,
                      ),
                    ),
                  );
                }).toList() ??
                [],
          );
        },
      );

  Widget _buildOverview() => GetUtil.getX<MovieDetailsViewModel>(
        builder: (vm) {
          MovieModel movieModel = vm.movieDetailsStream.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('overview'.translate(),
                  style: AppTextStyle.customTextStyle(
                    fontSize: AppSize.textSize_18,
                    fontWeightType: FontWeightType.bold,
                  )),
              SizedBox(height: AppSize.size_8),
              Text(
                movieModel.overview ?? '',
                style: AppTextStyle.customTextStyle(
                  color: AppColor.gray,
                  fontSize: AppSize.textSize_16,
                  fontWeightType: FontWeightType.medium,
                ),
              ),
            ],
          );
        },
      );
}
