import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiver/core/extensions/ext_datetime.dart';
import 'package:fiver/core/extensions/ext_localization.dart';
import 'package:fiver/core/res/colors.dart';
import 'package:fiver/core/res/theme/text_theme.dart';
import 'package:fiver/core/utils/util.dart';
import 'package:fiver/data/model/review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fiver/core/res/theme/theme_manager.dart';
import 'package:fiver/presentation/rating_and_review/rating_and_review_model.dart';
import 'package:like_button/like_button.dart';

import '../../widgets/check_box_widget.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({
    super.key,
    required this.model,
  });
  final RatingAndReviewModel model;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              SizedBox(height: 48.w),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: model.reviews,
                  builder: (context, reviews, child) {
                    return ListView.builder(
                      controller: model.reviewsScrollController,
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        if (index == 0) {
                          return Padding(
                            padding: EdgeInsets.only(top: 28.w),
                            child: _reviewItem(review, context),
                          );
                        }
                        return _reviewItem(review, context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _withPhoto(8, context),
          ),
        ],
      ),
    );
  }

  Widget _reviewItem(ReviewModel item, BuildContext context) {
    return Stack(
      key: ValueKey(item.uid),
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(32.w, 0.w, 32.w, 32.w),
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 25.r,
                blurStyle: BlurStyle.outer,
                color: color000000.withOpacity(
                  0.05,
                ),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: text14.bold.copyWith(
                  color: getColor().themeColor222222White,
                ),
              ),
              SizedBox(height: 8.w),
              _ratingAndDate(item),
              SizedBox(height: 11.w),
              _content(item.content),
              SizedBox(height: 20.w),
              _reviewPhotos(item.images),
              _helpful(context, item),
            ],
          ),
        ),
        _avatar(item.avatar),
      ],
    );
  }

  Widget _content(String content) {
    return Text(
      content,
      style: text14.copyWith(
        color: getColor().themeColor222222White,
      ),
    );
  }

  Widget _reviewPhotos(List<String> images) {
    return ValueListenableBuilder(
      valueListenable: model.withPhotoReview,
      builder: (context, withPhotoReview, child) {
        if (!withPhotoReview || images.isNullOrEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          height: 104.w,
          margin: EdgeInsets.only(bottom: 12.w),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              images.length,
              (index) => Container(
                width: 104.w,
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: CachedNetworkImage(
                    cacheKey: images[index],
                    imageUrl: images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _ratingAndDate(ReviewModel item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RatingBar.builder(
          itemBuilder: (context, index) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
            );
          },
          ignoreGestures: true,
          initialRating: item.rateStar.toDouble(),
          itemSize: 14.w,
          onRatingUpdate: (value) {},
        ),
        Text(
          item.createdDate.formatToDateString(type: 'MMMM dd, yyyy'),
          style: text11.copyWith(
            color: getColor().themeColorGrey,
          ),
        ),
      ],
    );
  }

  Widget _helpful(BuildContext context, ReviewModel item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => model.onHelpful(item.uid),
          child: Text(
            context.loc.helpful,
            style: text11.copyWith(
              color: item.isHelpful ? colordb3022 : getColor().themeColorGrey,
            ),
          ),
        ),
        SizedBox(width: 3.w),
        LikeButton(
          size: 20.w,
          onTap: (isLiked) => model.onHelpful(item.uid),
          isLiked: item.isHelpful,
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.thumb_up_alt_rounded,
              color: isLiked ? colordb3022 : colorDADADA,
              size: 20.w,
            );
          },
        ),
      ],
    );
  }

  Widget _avatar(String avatar) {
    return Positioned(
      top: -16.w,
      left: 8.w,
      child: CircleAvatar(
        radius: 24.r,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: avatar,
            fit: BoxFit.cover,
            width: 48.w,
            height: 48.w,
            placeholder: (context, url) {
              return const CircularProgressIndicator();
            },
            cacheKey: avatar,
          ),
        ),
      ),
    );
  }

  Widget _withPhoto(int review, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 0.w, 30.w, 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
            valueListenable: model.reviews,
            builder: (context, reviews, child) {
              return Text(
                "${reviews.length} ${context.loc.reviews}",
                style: text22.copyWith(
                  color: getColor().themeColor222222White,
                ),
              );
            },
          ),
          InkWell(
            onTap: () => model.onChangedWithPhotoReview(
              !model.withPhotoReview.value,
            ),
            child: Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: model.withPhotoReview,
                  builder: (context, withPhotoReview, child) {
                    return CheckBoxWidget(
                      onChanged: (value) {
                        model.onChangedWithPhotoReview(value!);
                      },
                      value: withPhotoReview,
                      activeColor: getColor().themeColor222222White,
                      checkColor: getColor().themeColorWhiteBlack,
                    );
                  },
                ),
                Text(
                  context.loc.with_photo,
                  style: text14.copyWith(
                    color: getColor().themeColor222222White,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
