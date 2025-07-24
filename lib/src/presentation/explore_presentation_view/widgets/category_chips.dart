import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/src/categories/presentation/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Assuming you have an IndexCubit for managing selected category
class CategoryChips extends StatelessWidget {
  const CategoryChips({
    super.key,
    required this.categoriesList,
    this.onCategorySelected,
  });

  final List<dynamic> categoriesList;
  final Function(String categoryId)? onCategorySelected;

  @override
  Widget build(BuildContext context) {
    if (categoriesList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: context.height * 0.1,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          final category = categoriesList[index];

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: BlocBuilder<IndexCubit, int>(
              builder: (context, selectedIndex) {
                final isSelected = selectedIndex == index;

                return FilterChip(
                  label: Text(
                    category.name ?? 'Category ${index + 1}',
                    style: TextStyle(
                      color: isSelected ? context.textColor : Colors.grey[600],
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    if (selected) {
                      onCategorySelected?.call(category.id);
                      context.read<IndexCubit>().selectIndex(index);
                    }
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  showCheckmark: false,
                  selectedColor: Colours.classicAdaptiveButtonOrIconColor(
                    context,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
