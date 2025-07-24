import 'dart:convert';

import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/categories/data/models/category_model.dart';
import 'package:e_triad/src/products/domain/entity/product.dart';
import 'package:e_triad/src/reviews/data/model/reviews_model.dart';
import 'package:e_triad/src/reviews/domain/entity/reviews.dart';

import '../../../categories/domain/entities/category.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.productId,
    required super.productName,
    required super.productDescription,
    required super.productPrice,
    required super.productImageUrl,
    super.ratings,
    super.productImages = const [],
    super.productColours = const [],
    super.sizes = const [],
    required super.category,
    required super.countInStock,
    super.reviews = const [],
    super.noOfReviews,
    super.genderAgeCategory,
    super.dateAdded,
  });

  const ProductModel.empty()
    : this(
        productId: '',
        productName: '',
        productDescription: '',
        productPrice: 0.0,
        ratings: 0,
        productImageUrl: '',
        productImages: const [],
        productColours: const [],
        sizes: const [],
        category: null,
        countInStock: 0,
        reviews: const [],
        noOfReviews: null,
        dateAdded: null,
        genderAgeCategory: null,
      );

  ProductModel copyWith({
    String? productId,
    String? productName,
    String? productDescription,
    double? productPrice,
    int? ratings,
    String? productImageUrl,
    List? productImages,
    List<dynamic>? productColours,
    List<dynamic>? sizes,
    Category? category,
    int? countInStock,
    List<Reviews>? reviews,
    int? noOfReviews,
    String? genderAgeCategory,
    String? dateAdded,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productPrice: productPrice ?? this.productPrice,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      ratings: ratings ?? this.ratings,
      category: category ?? this.category,
      countInStock: countInStock ?? this.countInStock,
      genderAgeCategory: genderAgeCategory ?? this.genderAgeCategory,

      reviews: reviews ?? this.reviews,
      noOfReviews: noOfReviews ?? this.noOfReviews,
      productColours: productColours ?? this.productColours,
      productImages: productImages ?? this.productImages,
      dateAdded: dateAdded ?? this.dateAdded,
      sizes: sizes ?? this.sizes,
    );
  }

  DataMap toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'productPrice': productPrice,
      'ratings': ratings,
      'productImageUrl': productImageUrl,
      'productImages':
          productImages?.map((productImage) => productImage).toList(),
      'productColours':
          productColours?.map((productColour) => productColour).toList(),
      'sizes': sizes?.map((size) => size).toList(),
      'category': (category as CategoryModel).toMap(),
      'countInStock': countInStock,
      if (reviews != null)
        'reviews':
            reviews!.map((review) => (review as dynamic).toMap()).toList(),
      'noOfReviews': noOfReviews,
      'genderAgeCategory': genderAgeCategory,
      'dateAdded': dateAdded,
    };
  }

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(jsonDecode(source));

  factory ProductModel.fromMap(DataMap map) {
    Category? category;
    if (map['category'] != null) {
      if (map['category'] is String) {
        
        category = CategoryModel.fromMap({
          'id':  map['id'] as String? ?? map['_id'] as String,
          'name': map['name'] as String? ?? '',
          'images': map['image'] as String? ?? '',
          'color': map['color'] as String? ?? '#000000',
          'markedForDeletion': false,
        });
      } else if (map['category'] is Map) {
       
        category = CategoryModel.fromMap(map['category'] as DataMap);
      }
    }
    return ProductModel(
      productId: map['id'] as String? ?? map['_id'] as String,
      productName: map['name'] as String? ?? '',
      productDescription: map['description'] as String? ?? '',
      productPrice: (map['price'] as num?)?.toDouble() ?? 0.0,
      ratings: (map['ratings'] as num?)?.toInt() ?? 0,
      productImageUrl: map['image'] as String? ?? '',
      category: category,
      reviews:
          map['reviews'] != null
              ? (map['reviews'] as List<dynamic>)
                  .map((reviewId) => ReviewsModel.fromMap({'user': reviewId}))
                  .toList()
              : const [],
      productColours: map['colours'] as List<dynamic>? ?? [],
      productImages: map['images']as List? ?? [],
      
      sizes: map['sizes'] as List<dynamic>? ?? [],
      noOfReviews: map['numberOfReviews'] as int? ?? 0,
      genderAgeCategory: map['genderAgeCategory'] as String? ?? '',
      dateAdded: map['dateAdded'] as String? ?? '',
      countInStock: map['countInStock'] as int? ?? 0,
    );
  }

  String toJson() => jsonEncode(toMap());
}
