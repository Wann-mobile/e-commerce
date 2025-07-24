import 'package:equatable/equatable.dart';

class Reviews extends Equatable {
  const Reviews({
    required this.user,
    required this.userName,
    required this.comment,
    required this.rating,
    this.date,
  });

  final String user;
  final String userName;
  final String comment;
  final int rating;
  final String? date;


  @override
  List<Object?> get props => [user, userName, comment, rating, date];
}
