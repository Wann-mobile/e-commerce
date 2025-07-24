
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/promotions.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/provider_sections/categories_section.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/provider_sections/new_arrivals_section.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/provider_sections/popular_products_section.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/provider_sections/search_section.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key,  this.paymentSuccess =false, this.reference});
  static const path = '/home';

final bool paymentSuccess;
  final String? reference;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
     if (widget.paymentSuccess && widget.reference != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        
        CoreUtils.showSnackBar(context, message: 'Order created successfully Ref: ${widget.reference}');
      });
     
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          children: [
            const SearchSection(),

            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 30),
                children: [
                  const Promotions(),
                  const Gap(10),

                  const CategoriesSection(),
                  const Gap(10),

                  const PopularProductsSection(),
                  const Gap(10),

                  const NewArrivalsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
