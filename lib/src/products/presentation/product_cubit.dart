import 'package:e_triad/core/common/app/bloc_providers/product_provider.dart';
import 'package:e_triad/src/products/domain/entity/product.dart';
import 'package:e_triad/src/products/domain/use_cases/get_all_products.dart';
import 'package:e_triad/src/products/domain/use_cases/get_new_arrivals.dart';
import 'package:e_triad/src/products/domain/use_cases/get_popular_products.dart';
import 'package:e_triad/src/products/domain/use_cases/get_product.dart';
import 'package:e_triad/src/products/domain/use_cases/get_products_by_category.dart';
import 'package:e_triad/src/products/domain/use_cases/search_all_product.dart';
import 'package:e_triad/src/products/domain/use_cases/search_by_gender_age.dart';
import 'package:e_triad/src/products/domain/use_cases/search_products_by_category.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required GetAllProducts getAllProducts,
    required GetPopularProducts getPopularProducts,
    required GetProduct getProduct,
    required GetProductsByCategory getProductsByCategory,
    required SearchAllProducts searchAllProducts,
    required SearchProductsByGenderAgeCategory
    searchProductsByGenderAgeCategory,
    required SearchProductsByCategory searchProductsByCategory,
    required ProductProvider productProvider,
  }) : _getAllProducts = getAllProducts,

       _getPopularProducts = getPopularProducts,
       _getProduct = getProduct,

       _getProductsByCategory = getProductsByCategory,
       _searchAllProducts = searchAllProducts,
       _searchProductsByCategory = searchProductsByCategory,
       _searchProductsByGenderAgeCategory = searchProductsByGenderAgeCategory,
       _productProvider = productProvider,
       super(const StateInitialProduct());

  final GetAllProducts _getAllProducts;

  final GetPopularProducts _getPopularProducts;
  final GetProduct _getProduct;
  final GetProductsByCategory _getProductsByCategory;
  final SearchAllProducts _searchAllProducts;
  final SearchProductsByGenderAgeCategory _searchProductsByGenderAgeCategory;
  final SearchProductsByCategory _searchProductsByCategory;
  final ProductProvider _productProvider;

  Future<void> getAllProducts({int page = 1}) async {
    if (state is StateFetchedAllProducts) {
      return;
    }
    emit(const StateProductLoading());
    final result = await _getAllProducts(page);

    result.fold((failure) => emit(StateProductError(failure.errorMessage)), (
      products,
    ) {
      emit(StateFetchedAllProducts(products));
    });
  }

  Future<void> getPopularProducts({int page = 1}) async {
    if (state is StateFetchedPopularProducts) {
      return;
    }
    emit(const StateProductLoading());

    final result = await _getPopularProducts(page);
    result.fold((failure) => emit(StateProductError(failure.errorMessage)), (
      products,
    ) {
      emit(StateFetchedPopularProducts(products));
    });
  }

  Future<void> getProduct(String productId) async {
    emit(const StateProductLoading());
    final result = await _getProduct(productId);
    result.fold((failure) => emit(StateProductError(failure.errorMessage)), (
      product,
    ) {
      _productProvider.setSelectedProduct(product);
      emit(StateFetchedProduct(product));
    });
  }

  Future<void> getProductsByCategory(String categoryId, {int page = 1}) async {
    emit(const StateProductLoading());
    final result = await _getProductsByCategory(
      GetProductsByCategoryParams(categoryId: categoryId, page: page),
    );
    result.fold((failure) => emit(StateProductError(failure.errorMessage)), (
      products,
    ) {
      emit(StateFetchedProductByCategory(products));
    });
  }

  Future<void> searchAllProducts(String searchTerm, {int page = 1}) async {
    emit(const StateProductLoading());
    final result = await _searchAllProducts(
      SearchAllProductParams(searchTerm: searchTerm, page: page),
    );
    result.fold((failure) => emit(StateProductError(failure.errorMessage)), (
      products,
    ) {
      emit(StateFoundAllProducts(products));
    });
  }

  Future<void> searchProductsByCategory(
    String searchTerm,
    String category, {
    int page = 1,
  }) async {
    emit(const StateProductLoading());
    final result = await _searchProductsByCategory(
      SearchProductsByCategoryParams(
        searchTerm: searchTerm,
        category: category,
        page: page,
      ),
    );
    result.fold((failure) => emit(StateProductError(failure.errorMessage)), (
      products,
    ) {
      emit(StateFoundProductsByCategory(products));
    });
  }

  Future<void> searchProductsByGenderAgeCategory(
    String searchTerm,
    String genderAgeCategory, {
    int page = 1,
  }) async {
    emit(const StateProductLoading());
    final result = await _searchProductsByGenderAgeCategory(
      SearchProductsByGenderAgeCategoryParams(
        searchTerm: searchTerm,
        genderAgeCategory: genderAgeCategory,
        page: page,
      ),
    );

    result.fold((failure) => emit(StateProductError(failure.errorMessage)), (
      products,
    ) {
      emit(StateFoundProductsByGenderAgeCategory(products));
    });
  }
}

class NewArrivalsCubit extends Cubit<ProductState> {
  NewArrivalsCubit({required GetNewArrivalProducts getNewArrivalProducts})
    : _getNewArrivalProducts = getNewArrivalProducts,
      super(const StateInitialProduct());

  final GetNewArrivalProducts _getNewArrivalProducts;

  Future<void> getNewArrivalProducts({int page = 1}) async {
    if (state is StateFetchedNewArrivals) {
      return;
    }
    emit(const StateProductLoading());
    final result = await _getNewArrivalProducts(page);

    result.fold((failure) => emit(StateProductError(failure.errorMessage)), (
      products,
    ) {
      emit(StateFetchedNewArrivals(products));
    });
  }
}
