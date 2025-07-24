import 'package:e_triad/src/products/domain/entity/product.dart';
import 'package:e_triad/src/products/presentation/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final SearchController _searchController = SearchController();
  final FocusNode _focusNode = FocusNode();

  void _dismissKeyboard() {
    _focusNode.unfocus();
    FocusScope.of(context).unfocus();
  }

  List<Product> _filterProducts(List<Product> products, String input) {
    return products
        .where(
          (product) =>
              product.productName.toLowerCase().contains(input.toLowerCase()),
        )
        .toList();
  }

  Widget _buildSuggestions(List<Product> products) {
    final input = _searchController.text;

    if (input.isEmpty) {
      return _buildEmptyState('Start typing to search products');
    }

    final matches = _filterProducts(products, input);

    if (matches.isEmpty) {
      return _buildEmptyState('No products found');
    }

    return ListView.builder(
      itemCount: matches.length,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final product = matches[index];
        return ListTile(
          title: Text(product.productName),
          onTap: () {
            context.read<ProductCubit>().getProduct(product.productId);
            _dismissKeyboard();
          },
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(child: Text(message, style: TextStyle(color: Colors.grey))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is StateFetchedAllProducts) {
          return Column(
            children: [
              SearchBar(
                controller: _searchController,
                focusNode: _focusNode,
                hintText: 'Search products...',
                onChanged: (_) => setState(() {}),
                leading: const Icon(Icons.search),
              ),
              Expanded(child: _buildSuggestions(state.allProducts)),
            ],
          );
        } else if (state is StateProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StateProductError) {
          return _buildEmptyState(state.message);
        }

        return _buildEmptyState('Loading...');
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
