import 'package:e_triad/core/utils/typedefs.dart';

import 'package:e_triad/src/products/domain/entity/product.dart';


abstract class ProductRepos {
  const ProductRepos();

  // Core product operations
  /// Get a single product by ID
  /// Maps to: getProductById(req.params.product.id)
  ResultFuture<Product> getProduct(String productId);

  /// Get all products with pagination (no filters)
  /// Maps to: getProducts() with no query params
  ResultFuture<List<Product>> getAllProducts({int page = 1});

  /// Get products by category
  /// Maps to: getProducts(category=category)
  ResultFuture<List<Product>> getProductsByCategory({
    required String category,
    int page = 1,
  });

  /// Get new arrival products (last 2 weeks)
  /// Maps to: getProducts(criteria='newArrivals')
  ResultFuture<List<Product>> getNewArrivalProducts({int page = 1});


  /// Get popular products (rating >= 4.5)
  /// Maps to: getProducts(criteria='popular')
  ResultFuture<List<Product>> getPopularProducts({int page = 1});

 

  // Search operations
  /// Search all products by text
  /// Maps to: searchProducts(q=searchTerm)
  ResultFuture<List<Product>> searchAllProducts({
    required String searchTerm,
    int page = 1,
  });

  /// Search products by category
  /// Maps to: searchProducts(q=searchTerm, category=category)
  ResultFuture<List<Product>> searchProductsByCategory({
    required String searchTerm,
    required String category,
    int page = 1,
  });

  /// Search products by gender/age category
  /// Maps to: searchProducts(q=searchTerm, genderAgeCategory=genderAgeCategory)
  ResultFuture<List<Product>> searchProductsByGenderAgeCategory({
    required String searchTerm,
    required String genderAgeCategory,
    int page = 1,
  });

  // /// Search products by both category and gender/age category
  // /// Maps to: searchProducts(q=searchTerm, category=category, genderAgeCategory=genderAgeCategory)
  // ResultFuture<List<Product>> searchProductsByCategoryAndGender({
  //   required String searchTerm,
  //   required String category,
  //   required String genderAgeCategory,
  //   int page = 1,
  // });

}