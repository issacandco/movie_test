import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_test/extensions/date_time_extension.dart';
import 'package:movie_test/models/genre_model.dart';
import 'package:movie_test/utils/get_storage_util.dart';
import 'package:movie_test/utils/get_util.dart';

import '../../models/movie_model.dart';
import '../../styles/app_color.dart';
import '../../styles/app_size.dart';
import '../../styles/app_text_style.dart';
import '../../utils/constant_util.dart';
import '../../widgets/theme/theme_shimmer.dart';
import '../movie_details/movie_details_screen.dart';

class ItemSearch extends StatelessWidget {
  final MovieModel movieModel;

  const ItemSearch({
    super.key,
    required this.movieModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GetUtil.navigateTo(MovieDetailsScreen(movieId: movieModel.id ?? 0));
      },
      child: Container(
        padding: EdgeInsets.all(AppSize.size_8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppSize.size_16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPoster(),
            SizedBox(width: AppSize.size_16),
            _buildMovieBasicInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildPoster() => ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.size_16),
        child: movieModel.poster != null && movieModel.poster!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: movieModel.poster!,
                width: AppSize.getScreenWidth(percent: 30),
                height: AppSize.getScreenHeight(percent: 18),
                fit: BoxFit.cover,
                placeholder: (context, url) => ThemeShimmer.rectangular(
                  width: AppSize.getScreenWidth(percent: 20),
                  height: AppSize.getScreenHeight(percent: 15),
                ),
                errorWidget: (context, url, error) => const SizedBox.shrink(),
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
              ),
      );

  Widget _buildMovieBasicInfo() => Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movieModel.title ?? '',
              style: AppTextStyle.customTextStyle(
                fontSize: AppSize.textSize_18,
                fontWeightType: FontWeightType.bold,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppSize.size_4),
            Row(
              children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: double.parse(movieModel.voteAverage != null ? movieModel.voteAverage!.toStringAsPrecision(2) : '0.00') / 2,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: AppSize.size_18,
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
                    fontSize: AppSize.textSize_14,
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
                    fontSize: AppSize.textSize_14,
                    fontWeightType: FontWeightType.regular,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSize.size_8),
            _buildGenres(),
          ],
        ),
      );

  Widget _buildGenres() => Wrap(
        spacing: AppSize.size_8,
        runSpacing: AppSize.size_8,
        children: movieModel.genreIds?.map((e) {
              List<GenreModel> genreList = GetStorageUtil.readFromGetStorage<List<GenreModel>>(key: ConstantUtil.keyGenres) ?? [];
              String genre = '';

              if (genreList.isNotEmpty) {
                Map<int, String> genreMap = {for (var genre in genreList) genre.id ?? 0: genre.name ?? ''};
                genre = genreMap[e] ?? '';
              }

              return Container(
                padding: EdgeInsets.symmetric(horizontal: AppSize.size_8, vertical: AppSize.size_4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.size_8),
                  color: AppColor.primaryColor,
                ),
                child: Text(
                  genre,
                  style: AppTextStyle.customTextStyle(
                    color: AppColor.white,
                    fontSize: AppSize.textSize_12,
                    fontWeightType: FontWeightType.medium,
                  ),
                ),
              );
            }).toList() ??
            [],
      );
}
