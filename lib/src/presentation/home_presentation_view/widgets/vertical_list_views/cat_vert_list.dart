import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';

class CatVertList extends StatelessWidget {
  const CatVertList({
    super.key,
    required this.categoryList,
    this.onCategoryTap,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
  });

  final List<dynamic> categoryList;
  final Function(dynamic category)? onCategoryTap;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState(context);
    }
    if (errorMessage != null) {
      return _buildErrorState(context);
    }
    if (categoryList.isEmpty) {
      return _buildEmptyState(context);
    }
    return ListView.builder(
      itemCount: categoryList.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final category = categoryList[index];
        return GestureDetector(
          onTap: () => onCategoryTap?.call(category),
          child: Container(
            height: context.height * 0.1,
            width: context.width * 0.18,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colours.classicAdaptiveBgCardColor(context),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(5),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildImageInfo(context, index, categoryList),

                Expanded(
                  child: Center(
                    child: _buildCategoryName(context, index, categoryList),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    const height = 90.0;
    const width = 300.0;
    return ListView.builder(
      itemCount: categoryList.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Container(
          height: height,
          width: width,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colours.classicAdaptiveBgCardColor(context),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(5),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: height,
                height: double.maxFinite,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200,
                ),
              ),

              Expanded(child: Center(child: Text(''))),
            ],
          ),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No Categories',
            style: context.theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildImageInfo(BuildContext context, int index, dynamic category) {
    return Container(
      width: context.width * 0.2,
      height: double.maxFinite,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(category[index].images),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _buildCategoryName(BuildContext context, int index, dynamic category) {
    return Text(
      category[index].name,
      style: context.theme.textTheme.titleLarge!.copyWith(
        color: context.textColor,
      ),
    );
  }
}
