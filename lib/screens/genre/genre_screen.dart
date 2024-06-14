import 'package:flutter/material.dart';
import 'package:movie_test/models/genre_model.dart';
import 'package:movie_test/screens/genre/genre_view_model.dart';
import 'package:movie_test/screens/recent_search/recent_search_view_model.dart';
import 'package:movie_test/styles/app_size.dart';
import 'package:movie_test/styles/app_text_style.dart';
import 'package:movie_test/utils/get_util.dart';
import 'package:movie_test/widgets/no_data_widget.dart';
import 'package:movie_test/widgets/theme/theme_app_bar.dart';
import 'package:movie_test/widgets/theme/theme_button.dart';
import 'package:movie_test/widgets/theme/theme_dialog.dart';

import '../../base/base_page.dart';
import '../../styles/app_color.dart';
import '../../utils/asset_util.dart';

class GenreScreen extends BasePage {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends BaseState<GenreScreen> with BasicPage {
  final GenreViewModel _genreViewModel = GetUtil.put(GenreViewModel());

  @override
  PreferredSizeWidget? appBar() {
    return ThemeAppBar(
      titleName: 'genre'.translate(),
    );
  }

  @override
  Widget body() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(AppSize.standardSize),
        child: Column(
          children: [
            _buildGenreList(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreList() {
    return Container(
      child: GetUtil.getX<GenreViewModel>(
        builder: (vm) {
          List<GenreModel> genreList = vm.genreListStream;
          return Visibility(
            visible: genreList.isNotEmpty,
            replacement: const NoDataWidget(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'may_select_multiple_genre'.translate(),
                  style: AppTextStyle.customTextStyle(
                    fontSize: AppSize.textSize_16,
                    fontWeightType: FontWeightType.medium,
                  ),
                ),
                SizedBox(height: AppSize.size_8),
                Wrap(
                  spacing: AppSize.size_8,
                  runSpacing: AppSize.size_8,
                  children: genreList
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            vm.onSelectGenre(e);
                          },
                          child: Chip(
                            backgroundColor: vm.isSelected(e) ? AppColor.primaryColor : Colors.transparent,
                            label: Text(
                              e.name ?? '',
                              style: AppTextStyle.customTextStyle(
                                color: vm.isSelected(e) ? Colors.white : AppColor.black,
                                fontSize: AppSize.textSize_16,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildButton() => Container(
        margin: EdgeInsets.symmetric(vertical: AppSize.size_24),
        child: GetUtil.getObx(
          () => ThemeButton(
            enabled: _genreViewModel.selectedGenresStream.isNotEmpty,
            fitType: FitType.fit,
            onPressed: () {
              GetUtil.backWithResult(_genreViewModel.selectedGenresStream);
            },
            text: 'done'.translate(),
          ),
        ),
      );
}
