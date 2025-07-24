import 'package:e_triad/src/categories/domain/entities/category.dart';
import 'package:e_triad/src/reviews/domain/entity/reviews.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImageUrl,
     this.ratings,
    this.productImages = const [],
    this.productColours= const [],
    this.sizes= const [],
    required this.category,
    required this.countInStock,
    this.reviews =  const [],
    this.noOfReviews,
    this.genderAgeCategory,
    this.dateAdded,
  });
  const Product.empty()
    : productId ='',
     productName = '',
      productDescription = '',
      productPrice = 0.0,
      ratings = 0,
      productImageUrl = '',
      productImages = const [],
      productColours = const [],
      sizes = const [],
      category = null,
      countInStock = 0,
      reviews =  const [],
      noOfReviews = null,
      genderAgeCategory = null,
      dateAdded = '';
      

  final String productId;
  final String productName;
  final String productDescription;
  final double productPrice;
  final int? ratings;
  final String productImageUrl;
  final List? productImages;
  final List<dynamic>? productColours;
  final List<dynamic>? sizes;
  final Category? category;
  final int countInStock;
  final List<Reviews>? reviews;
  final int? noOfReviews;
  final String? genderAgeCategory;
  final String? dateAdded;
  

  @override
  List<Object?> get props => [
    productId,
    productName,
    productDescription,
    productPrice,
    ratings,
    productImageUrl,
    productImages,
    productColours,
    sizes,
    reviews,
    category,
    countInStock,
    noOfReviews,
    genderAgeCategory,
    dateAdded,
  ];
}
