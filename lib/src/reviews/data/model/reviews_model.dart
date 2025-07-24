import 'dart:convert';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/reviews/domain/entity/reviews.dart';

class ReviewsModel extends Reviews {
  const ReviewsModel({
    required super.user,
    required super.userName,
    required super.comment,
    required super.rating,
    super.date,
  });

  const ReviewsModel.empty()
    : this(
        user: '',
        userName: '',
        comment: '',
        rating: 0,
        date: null,
      );

  ReviewsModel copyWith({
    String? user,
    String? userName,
    String? comment,
    int? rating,
    String? date,
  }) {
    return ReviewsModel(
      user: user ?? this.user,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
      userName: userName ?? this.userName,
      date: date ?? this.date,
    );
  }

  DataMap toMap() {
    return {
      'user': user,
      'userName': userName,
      'comment': comment,
      'rating': rating,
      'date': date,
    };
  }

  factory ReviewsModel.fromJson(String source) =>
      ReviewsModel.fromMap(jsonDecode(source) as DataMap);

  ReviewsModel.fromMap(DataMap map)
    : this(
        user: map['user'] as String,
        userName: map['userName'] as String,
        comment: map['comment'] as String,
        rating: map['rating'] as int,
        date: map['date'] as String,
      );

  String toJson() => jsonEncode(toMap());
}
