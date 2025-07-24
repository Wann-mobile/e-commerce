import 'package:e_triad/core/common/widgets/category_circle.dart';
import 'package:e_triad/core/common/widgets/view_all.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
    required this.title,
    required this.categoryList,
    this.onViewAll,
    this.onCategoryTap,
    this.errorMessage,
    this.isLoading = false,
    this.onRetry,
  });
  final String title;
  final List<dynamic> categoryList;
  final VoidCallback? onViewAll;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final Function(dynamic category)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewAll(title: title, onViewAllPressed: onViewAll ?? () {}),
        SizedBox(
          height: context.height * 0.1090,
          child: _buildContent(context),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return _buildLoading(context);
    }
    if (errorMessage != null) {
      return _buildErrorState(context);
    }
    if (categoryList.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final category = categoryList[index];

        return Column(
          children: [
            CategoryCircle(
              category: categoryList[index],
              index: index,
              onTap: () => onCategoryTap?.call(category),
            ),
            Gap(10),
            Text(
              category.name,
              textAlign: TextAlign.left,
              style: context.theme.textTheme.bodySmall!.copyWith(
                color: Colours.classicAdaptiveTextColor(context),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    const containerMeasure = 55.0;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      shrinkWrap: true,

      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: containerMeasure,
              height: containerMeasure,

              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
            ),
            Gap(5),
            Text(''),
          ],
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            errorMessage ?? 'Something went wrong',
            style: context.theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    const double circleSize = 50;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,

      shrinkWrap: true,

      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              height: circleSize,
              width: circleSize,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
            ),
            Gap(10),
            Text(''),
          ],
        );
      },
    );
  }
}
