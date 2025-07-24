part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

final class StateInitialProduct extends ProductState {
  const StateInitialProduct();
}

final class StateProductLoading extends ProductState {
  const StateProductLoading();
}

// FETCHED STATES
final class StateFetchedAllProducts extends ProductState {
  const StateFetchedAllProducts(this.allProducts);

  final List<Product> allProducts;

  @override
  List<Object?> get props => [allProducts];
}

final class StateFetchedNewArrivals extends ProductState {
  const StateFetchedNewArrivals(this.newArrivals);

  final List<Product> newArrivals;

  @override
  List<Object?> get props => [newArrivals];
}

final class StateFetchedPopularProducts extends ProductState {
  const StateFetchedPopularProducts(this.popularProducts);

  final List<Product> popularProducts;

  @override
  List<Object?> get props => [popularProducts];
}

final class StateFetchedProduct extends ProductState {
  const StateFetchedProduct(this.product);

  final Product product;
  @override
  List<Object?> get props => [product];
}

final class StateFetchedProductByCategory extends ProductState {
  const StateFetchedProductByCategory(this.productList);

  final List<Product> productList;
  @override
  List<Object?> get props => [productList];
}

final class StateFoundAllProducts extends ProductState {
  const StateFoundAllProducts(this.searchedProductList);

  final List<Product> searchedProductList;
  @override
  List<Object?> get props => [searchedProductList];
}

final class StateFoundProductsByGenderAgeCategory extends ProductState {
  const StateFoundProductsByGenderAgeCategory(this.searchedProductList);

  final List<Product> searchedProductList;
  @override
  List<Object?> get props => [searchedProductList];
}

final class StateFoundProductsByCategory extends ProductState {
  const StateFoundProductsByCategory(this.searchedProductList);

  final List<Product> searchedProductList;
  @override
  List<Object?> get props => [searchedProductList];
}

// FAILED STATE
final class StateProductError extends ProductState {
  const StateProductError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
