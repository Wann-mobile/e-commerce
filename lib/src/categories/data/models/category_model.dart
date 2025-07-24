import 'dart:convert';

import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/categories/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.images,
    super.color,
    super.markedForDeletion,
  });

  const CategoryModel.empty()
    : this(id: '', name: '', images: '', color: '', markedForDeletion: false);

  CategoryModel copyWith({
    String? id,
    String? name,
    String? images,
    String? color,
    bool? markedForDeletion,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      images: images ?? this.images,
      color: color ?? this.color,
      markedForDeletion: markedForDeletion ?? this.markedForDeletion,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'images': images,
      'color': color,
      'markedForDeletion': markedForDeletion,
    };
  }

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(jsonDecode(source) as DataMap);

 CategoryModel.fromMap(DataMap map)
  : this(
      id: map['id'] as String? ?? map['_id'] as String? ?? '',
      name: map['name'] as String,
      images: map['images'] as String? ?? map['image'] as String? ?? '',
      color: map['color'] as String? ?? '#000000',
      markedForDeletion: map['markedForDeletion'] as bool? ?? false,
    );

  String toJson() => jsonEncode(toMap());
}
