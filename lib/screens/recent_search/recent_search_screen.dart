import 'package:flutter/material.dart';
import 'package:movie_test/screens/recent_search/recent_search_view_model.dart';
import 'package:movie_test/styles/app_size.dart';
import 'package:movie_test/styles/app_text_style.dart';
import 'package:movie_test/utils/get_util.dart';
import 'package:movie_test/widgets/no_data_widget.dart';
import 'package:movie_test/widgets/theme/theme_app_bar.dart';
import 'package:movie_test/widgets/theme/theme_dialog.dart';

import '../../base/base_page.dart';
import '../../styles/app_color.dart';
import '../../utils/asset_util.dart';

class RecentSearchScreen extends BasePage {
  const RecentSearchScreen({super.key});

  @override
  State<RecentSearchScreen> createState() => _RecentSearchScreenState();
}

class _RecentSearchScreenState extends BaseState<RecentSearchScreen> with BasicPage {
  final RecentSearchViewModel _recentSearchViewModel = GetUtil.put(RecentSearchViewModel());

  @override
  PreferredSizeWidget? appBar() {
    return ThemeAppBar(
      titleName: 'recent_search'.translate(),
      appBarActions: [
        GetUtil.getObx(
          () => Visibility(
            visible: _recentSearchViewModel.recentSearchListStream.isNotEmpty,
            child: IconButton(
              onPressed: () {
                ThemeDialog.show(
                  message: 'msg_confirm_clear'.translate(),
                  positiveAction: () {
                    _recentSearchViewModel.onClearRecentSearch();
                  },
                  negativeAction: () {},
                  positiveLabel: 'confirm'.translate(),
                  negativeLabel: 'cancel'.translate(),
                );
              },
              icon: AssetUtil.icClear(),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget body() {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.all(AppSize.standardSize),
      child: Column(
        children: [
          _buildRecentSearch(),
        ],
      ),
    ));
  }

  Widget _buildRecentSearch() {
    return Container(
      child: GetUtil.getX<RecentSearchViewModel>(
        builder: (vm) {
          List<String> recentSearchList = vm.recentSearchListStream;
          return Visibility(
            visible: recentSearchList.isNotEmpty,
            replacement: const NoDataWidget(),
            child: Wrap(
              spacing: AppSize.size_8,
              runSpacing: AppSize.size_8,
              children: recentSearchList
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        GetUtil.backWithResult(e.toString());
                      },
                      child: Chip(
                        label: Text(
                          e,
                          style: AppTextStyle.customTextStyle(
                            fontSize: AppSize.textSize_16,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
