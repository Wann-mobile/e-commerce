import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/src/presentation/home_presentation_view/sub_views/product_detail_view.dart';
import 'package:e_triad/src/products/presentation/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final SearchController searchController = SearchController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _dismissKeyboard() {
    _focusNode.unfocus();
    FocusScope.of(context).unfocus();
  }

  void _onSuggestionTapped(int index, String productName, ProductState state) {
    if (state is StateFetchedAllProducts) {
      context.read<ProductCubit>().getProduct(
        state.allProducts[index].productId,
      );
      context.push(
        ProductDetailView.path,
        extra: state.allProducts[index].productId,
      );
      _dismissKeyboard();
    }
  }

  Iterable<Widget> _buildSearchSuggestions({
    required String input,
    required StateFetchedAllProducts state,
  }) {
    final productNames =
        state.allProducts.map((product) => product.productName).toList();

    return productNames
        .asMap()
        .entries
        .where(
          (entry) => entry.value.toLowerCase().startsWith(input.toLowerCase()),
        )
        .map((entry) {
          final int index = entry.key;
          final String productName = entry.value;

          return ListTile(
            title: Text(
              productName,
              style: TextStyle(color: context.textColor),
            ),
            onTap: () {
              searchController.text = productName;
              _onSuggestionTapped(index, productName, state);
            },
          );
        });
  }

  Widget _buildEmptyState(String message) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          message,
          style: context.theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Iterable<Widget> _buildSuggestions(
    BuildContext context,
    SearchController controller,
    ProductState state,
  ) {
    if (controller.text.isEmpty) {
      final message =
          state is StateProductLoading
              ? 'Loading products...'
              : 'Start typing to search products';
      return [_buildEmptyState(message)];
    }

    if (state is StateFetchedAllProducts) {
      final suggestions = _buildSearchSuggestions(
        input: controller.text,
        state: state,
      );

      if (suggestions.isEmpty) {
        return [_buildEmptyState('No products found')];
      }

      return suggestions;
    }

    return [_buildEmptyState('No products found')];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        switch (state) {
          case StateProductError(:final message):
            CoreUtils.showSnackBar(context, message: message);
            break;
          case StateProductLoading():
            Container();
            break;
          case StateFetchedProduct():
            CoreUtils.showSnackBar(context, message: 'Opening product');
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return SearchAnchor.bar(
          searchController: searchController,
          onTap: () {
            context.read<ProductCubit>().getAllProducts();
          },
          suggestionsBuilder:
              (context, controller) =>
                  _buildSuggestions(context, controller, state),

          // Search bar configuration
          barLeading: const Icon(
            IconlyBroken.search,
            color: Colors.grey,
            size: 20,
          ),
          barHintText: 'Search products...',
          barTrailing: [
            IconButton(
              icon: const Icon(
                IconlyBroken.filter,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: () {
                debugPrint('Filter button pressed');
              },
            ),
          ],
          barTextStyle: WidgetStateProperty.all(
            context.theme.textTheme.bodyLarge,
          ),
          
          textInputAction: TextInputAction.search,
          // Full screen search configuration
          isFullScreen: true,
          viewBackgroundColor: context.backgroundColor,
          viewLeading: IconButton(
            icon: Icon(
              IconlyBroken.arrow_left,
              color: Colours.classicAdaptiveSurfaceColor(context),
            ),
            onPressed: () {
              _dismissKeyboard();
              searchController.clear();
              Navigator.of(context).pop();
            },
          ),

          keyboardType: TextInputType.text,
        );
      },
    );
  }
}
