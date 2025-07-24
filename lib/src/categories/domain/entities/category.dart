import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    this.color,
    required this.images,
    this.markedForDeletion = false,
  });
  final String id;
  final String name;
  final String? color;
  final String images;
  final bool markedForDeletion;

 
  @override
  List<Object?> get props => [id,name, color, images, markedForDeletion];
}
