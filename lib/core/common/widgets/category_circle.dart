import 'package:flutter/material.dart';

class CategoryCircle extends StatelessWidget {
  const CategoryCircle({
    super.key,
    required this.category,
    this.onTap,
    required this.index,
  });

  final dynamic category;
  final VoidCallback? onTap;
  final int index;
  static const double circleSize = 55;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: circleSize,
        height: circleSize,

        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 4),

        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(category.images),
            fit: BoxFit.fitWidth,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
