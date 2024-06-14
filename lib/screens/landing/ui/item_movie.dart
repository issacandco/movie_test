import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_test/extensions/date_time_extension.dart';
import 'package:movie_test/screens/movie_details/movie_details_screen.dart';

import '../../../models/movie_model.dart';
import '../../../styles/app_color.dart';
import '../../../styles/app_size.dart';
import '../../../styles/app_text_style.dart';
import '../../../utils/get_util.dart';
import '../../../widgets/theme/theme_shimmer.dart';

class ItemMovie extends StatelessWidget {
  const ItemMovie({super.key, required this.movieModel});

  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GetUtil.navigateTo(MovieDetailsScreen(movieId: movieModel.id ?? 0));
      },
      child: Container(
        padding: EdgeInsets.all(AppSize.size_16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppSize.size_12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Align(
                alignment: Alignment.center,
                child: movieModel.poster != null && movieModel.poster!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.size_8),
                        child: CachedNetworkImage(
                          imageUrl: movieModel.poster ?? '',
                          width: AppSize.getScreenWidth(),
                          height: AppSize.getScreenHeight(),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => ThemeShimmer.rectangular(),
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
                      ),
              ),
            ),
            SizedBox(height: AppSize.size_8),
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
        ),
      ),
    );
  }
}
