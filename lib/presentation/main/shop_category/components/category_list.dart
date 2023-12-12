import 'package:fiver/core/res/colors.dart';
import 'package:fiver/core/res/theme/text_theme.dart';
import 'package:fiver/core/res/theme/theme_manager.dart';
import 'package:fiver/data/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../shop_category_model.dart';

class CategoryList extends StatelessWidget {
  final ShopCategoryModel model;
  const CategoryList({
    super.key,
    required this.model,
  });

  Widget _categoryItem(CategoryModel item) {
    return GestureDetector(
      onTap: () {
        model.onGoToCategoryDetail(item);
      },
      child: Container(
        width: 343.w,
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 23.0.w),
                child: Text(
                  item.category,
                  style: text18.copyWith(
                    color: getColor().themeColor222222White,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Image.asset(
                item.urlImages,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryShimmerItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.w),
      width: 343.w,
      height: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: colordb3022,
      ),
    );
  }

  Widget _categoryShimmerList() {
    return Shimmer.fromColors(
      baseColor: getColor().themeColorAAAAAAA.withOpacity(0.4),
      highlightColor: getColor().themeColorAAAAAAA.withOpacity(0.2),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _categoryShimmerItem(),
          _categoryShimmerItem(),
          _categoryShimmerItem(),
          _categoryShimmerItem(),
        ],
      ),
    );
  }

  Widget _categoryBanner() {
    return Container(
      width: 343.w,
      height: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: colordb3022,
      ),
      alignment: Alignment.center,
      child: Text(
        "SUMMER SALES",
        style: text24.copyWith(
          color: colorWhite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.w),
              _categoryBanner(),
              SizedBox(height: 16.w),
              ValueListenableBuilder(
                valueListenable: model.categories,
                builder: (context, categories, child) {
                  if (categories.isEmpty) {
                    return _categoryShimmerList();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: categories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.w),
                        child: _categoryItem(category),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}