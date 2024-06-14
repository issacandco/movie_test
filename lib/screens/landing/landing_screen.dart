import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_test/models/movie_model.dart';
import 'package:movie_test/screens/landing/landing_view_model.dart';
import 'package:movie_test/screens/landing/ui/item_category.dart';
import 'package:movie_test/utils/get_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../base/base_page.dart';
import '../../styles/app_size.dart';
import '../../styles/app_text_style.dart';
import '../../utils/asset_util.dart';
import '../../widgets/loading_widget.dart';
import '../search/search_screen.dart';
import 'ui/item_movie.dart';

class LandingScreen extends BasePage {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends BaseState<LandingScreen> with BasicPage, WidgetsBindingObserver {
  final LandingViewModel _landingViewModel = GetUtil.put(LandingViewModel());

  @override
  void initState() {
    super.initState();

    _landingViewModel.addResponseListener(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleBar(),
          _buildCategories(),
          _buildMovieList(),
        ],
      ),
    );
  }

  Widget _buildTitleBar() {
    return Container(
      height: kToolbarHeight,
      padding: EdgeInsets.symmetric(horizontal: AppSize.standardSize),
      margin: EdgeInsets.only(bottom: AppSize.size_24),
      child: Row(
        children: [
          Text(
            'tmdb'.translate(),
            style: AppTextStyle.customTextStyle(
              fontSize: AppSize.textSize_22,
              fontWeightType: FontWeightType.bold,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              _goToSearchScreen();
            },
            child: AssetUtil.icSearch(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      margin: EdgeInsets.only(bottom: AppSize.size_24),
      child: GetUtil.getX<LandingViewModel>(
        builder: (vm) {
          List<Map<String, dynamic>> categoryList = vm.categoryListStream;
          Map<String, dynamic> selectedCategory = vm.selectedCategoryStream;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: AppSize.size_8,
              children: categoryList
                  .asMap()
                  .map(
                    (key, value) => MapEntry(
                      key,
                      Wrap(
                        children: [
                          Visibility(
                            visible: key == 0,
                            child: SizedBox(width: AppSize.size_24),
                          ),
                          ItemCategory(
                            category: value,
                            onTap: () {
                              vm.onCategorySelected(value);
                            },
                            isSelected: selectedCategory == value,
                          ),
                          Visibility(
                            visible: key == categoryList.length - 1,
                            child: SizedBox(width: AppSize.size_24),
                          ),
                        ],
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieList() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSize.standardSize),
        child: GetUtil.getX<LandingViewModel>(
          builder: (vm) {
            List<MovieModel> movieList = vm.movieListStream;

            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: movieList.length,
              itemBuilder: (context, index) {
                return ItemMovie(movieModel: movieList[index]);
              },
            );
          },
        ),
      ),
    );
  }

  _goToSearchScreen() {
    GetUtil.navigateTo(const SearchScreen(), transitionType: TransitionType.fade);
  }
}
