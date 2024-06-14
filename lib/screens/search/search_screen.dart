import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_test/models/genre_model.dart';
import 'package:movie_test/models/movie_model.dart';
import 'package:movie_test/screens/genre/genre_screen.dart';
import 'package:movie_test/screens/search/item_search.dart';
import 'package:movie_test/screens/search/search_view_model.dart';
import 'package:movie_test/styles/app_text_style.dart';
import 'package:movie_test/utils/get_util.dart';

import '../../base/base_page.dart';
import '../../styles/app_color.dart';
import '../../styles/app_size.dart';
import '../../utils/asset_util.dart';
import '../../widgets/theme/theme_app_bar.dart';
import '../../widgets/theme/theme_button.dart';
import '../../widgets/theme/theme_text.dart';
import '../recent_search/recent_search_screen.dart';

class SearchScreen extends BasePage {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends BaseState<SearchScreen> with BasicPage {
  final _searchTec = TextEditingController();
  final _searchFocusNode = FocusNode();
  final SearchViewModel _searchViewModel = GetUtil.put(SearchViewModel());

  @override
  void initState() {
    super.initState();
    _searchFocusNode.requestFocus();
  }

  @override
  PreferredSizeWidget? appBar() {
    return ThemeAppBar(
      titleName: 'search_movies'.translate(),
    );
  }

  @override
  Widget body() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSize.standardSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBarAndFilter(),
            _buildRecentSearch(),
            _buildSelectedGenres(),
            _buildSearchResultList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBarAndFilter() => Container(
        margin: EdgeInsets.only(bottom: AppSize.size_24),
        child: Row(
          children: [
            Expanded(
              child: ThemeTextField(
                fillColor: Theme.of(context).colorScheme.primaryContainer,
                controller: _searchTec,
                focusNode: _searchFocusNode,
                hintText: 'search_movies'.translate(),
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: Theme.of(context).iconTheme.color,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSize.size_16,
                  vertical: AppSize.size_8,
                ),
                textCapitalization: TextCapitalization.characters,
                onTextChanged: (value) {
                  _searchViewModel.setSearchText(value);
                },
                maxLines: 1,
                inputBorderRadius: AppSize.size_24,
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (value) {
                  _searchViewModel.onSearch(query: value ?? '');
                },
              ),
            ),
            SizedBox(width: AppSize.size_8),
            GestureDetector(
              onTap: () async {
                List<GenreModel>? selectedGenres = await GetUtil.navigateToWithResult(const GenreScreen());
                if (selectedGenres != null) {
                  _searchViewModel.setGenreList(selectedGenres);
                  _searchViewModel.onDiscoverMovie();
                }
              },
              child: AssetUtil.icFilter(),
            ),
          ],
        ),
      );

  Widget _buildRecentSearch() {
    return InkWell(
      onTap: () async {
        String? result = await GetUtil.navigateToWithResult(const RecentSearchScreen());
        if (result != null && result.isNotEmpty) {
          _searchViewModel.onSearch(query: result, isFromRecentSearch: true);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: AppSize.size_24),
        child: Row(
          children: [
            Text(
              'recent_search'.translate(),
              style: AppTextStyle.customTextStyle(
                fontSize: AppSize.textSize_16,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: AppSize.size_16),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedGenres() {
    return Container(
      margin: EdgeInsets.only(bottom: AppSize.size_24),
      child: GetUtil.getX<SearchViewModel>(
        builder: (vm) {
          List<GenreModel> selectedGenreList = vm.selectedGenreListStream;

          return Text(
            'Selected genres: ${selectedGenreList.isEmpty ? 'none' : selectedGenreList.map((e) => e.name).join(', ')}',
            style: AppTextStyle.customTextStyle(
              fontSize: AppSize.textSize_16,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchResultList() => Expanded(
        child: GetUtil.getX<SearchViewModel>(
          builder: (vm) {
            List<MovieModel> searchResultList = vm.movieListStream;

            return ListView.separated(
              shrinkWrap: true,
              itemCount: searchResultList.length,
              itemBuilder: (context, index) {
                return ItemSearch(movieModel: searchResultList[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: AppSize.size_8);
              },
            );
          },
        ),
      );
}
