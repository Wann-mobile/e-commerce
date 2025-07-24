import 'package:e_triad/src/presentation/explore_presentation_view/widgets/product_explore_card.dart';
import 'package:e_triad/src/presentation/home_presentation_view/sub_views/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExploreGridView extends StatelessWidget {
  const ExploreGridView({super.key, required this.productsList,});
  final List<dynamic> productsList;

 
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: productsList.length,
      itemBuilder: (context, index) {
        final product = productsList[index];

        return ProductExploreCard(
          product: product,
          onTap:
              () => context.push(
                ProductDetailView.path,
                extra: product.productId,
              ),
        );
      },
    );
  }
}
