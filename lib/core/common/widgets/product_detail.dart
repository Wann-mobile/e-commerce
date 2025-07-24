import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/src/cart_product/presentation/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class ProductDetailWidget extends StatelessWidget {
  const ProductDetailWidget({
    super.key,
    required this.productImageUrl,
    required this.productName,
    required this.productPrice,
    required this.ratings,
    required this.noOfReviews,
    required this.productDescription,
    this.onAddtoCart,
    required this.reviews, 
    this.product,
  });

  final String productImageUrl;
  final String productName;
  final double productPrice;
  final int? ratings;
  final int? noOfReviews;
  final String productDescription;
  final List<dynamic>? reviews;
  final VoidCallback? onAddtoCart;
  final dynamic product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageSection(productImageUrl: productImageUrl),
                  const Gap(16),
                  ProductInfoSection(
                    noOfReviews: noOfReviews,
                    productName: productName,
                    productPrice: productPrice,
                    ratings: ratings,
                  ),
                  const Gap(16),
                  ProductSizeSelector(product: product,),
                  const Gap(20),
                  ProductDescriptionSection(
                    productDescription: productDescription,
                  ),
                  const Gap(20),
                  CustomerReviewsSection(reviews: reviews),
                  const Gap(20),
                  const ReviewInputSection(),
                  const Gap(100),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: context.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: RoundedButton(text: 'Add to Cart', onPressed: onAddtoCart),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({super.key, required this.productImageUrl});
  final String productImageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(productImageUrl, fit: BoxFit.cover),
      ),
    );
  }
}

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.ratings,
    required this.noOfReviews,
  });
  final String productName;
  final double productPrice;
  final int? ratings;
  final int? noOfReviews;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(8),
              ProductRatingWidget(
                ratings: ratings ?? 0,
                noOfReviews: noOfReviews ?? 0,
              ),
            ],
          ),
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'NGN $productPrice',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.textColor,
              ),
            ),
            Text(
              'NGN ${productPrice + 20000}',
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProductRatingWidget extends StatelessWidget {
  const ProductRatingWidget({
    super.key,
    required this.ratings,
    required this.noOfReviews,
  });
  final int ratings;
  final int noOfReviews;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < ratings ? IconlyBold.star : IconlyBroken.star,
              size: 16,
              color: Colors.amber,
            );
          }),
        ),
        const Gap(8),
        Text(
          '$ratings',
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(4),
        Text(
          '($noOfReviews reviews)',
          style: context.theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class ProductSizeSelector extends StatefulWidget {
  const ProductSizeSelector({super.key, this.product});
final dynamic product;
  @override
  State<ProductSizeSelector> createState() => _ProductSizeSelectorState();
}

class _ProductSizeSelectorState extends State<ProductSizeSelector> {
  int selectedIndex = 0;
  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  late final dynamic product;
@override
  void initState() {
   
    super.initState();
product = widget.product;

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(12),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sizes.length,
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                   setState(() {
                      selectedIndex = index;
                    });
                    
                   
                    CartProvider.instance.setSelectedSize(product.productId, sizes[index]);
                    
                    // Automatically call the callback with selected size after a short delay
                    // Future.delayed(const Duration(milliseconds: 300), () {
                    //   widget.onSizeSelected(sizes[index]);
                    // });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Colours.classicAdaptiveButtonOrIconColor(
                                context,
                              )
                              : context.adaptiveColor(
                                lightColor: Colors.grey.shade200,
                                darkColor: Colors.grey.shade600,
                              ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        sizes[index],
                        style: context.textTheme.titleMedium?.copyWith(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProductDescriptionSection extends StatelessWidget {
  const ProductDescriptionSection({
    super.key,
    required this.productDescription,
  });
  final String productDescription;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        const Gap(12),
        Text(
          productDescription,
          style: context.textTheme.bodyMedium?.copyWith(
            height: 1.5,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

class CustomerReviewsSection extends StatelessWidget {
  const CustomerReviewsSection({super.key, required this.reviews});

  final List<dynamic>? reviews;

  @override
  Widget build(BuildContext context) {
    final hasReviews = reviews != null && reviews!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Customer Reviews',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (hasReviews)
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Colours.classicAdaptiveButtonOrIconColor(context),
                  ),
                ),
              ),
          ],
        ),
        const Gap(12),
        if (hasReviews)
          ...reviews!.map(
            (review) => ReviewCard(
              userName: review.userName,
              userRating: review.userRating,
              userComment: review.userComment,
              date: review.date,
            ),
          )
        else
          const NoReviewsWidget(),
      ],
    );
  }
}

class NoReviewsWidget extends StatelessWidget {
  const NoReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const Gap(16),
          Text(
            'No Reviews Yet',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const Gap(8),
          Text(
            'Be the first to share your thoughts about this product!',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.userName,
    required this.userRating,
    required this.date,
    required this.userComment,
  });

  final String userName;
  final int userRating;
  final String date;
  final String userComment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colours.classicAdaptiveBgCardColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: context.circlebgColor.withAlpha(1),
                child: Text(
                  userName.initials.toUpperCase(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName.toUpperCase(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < userRating
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 14,
                              color: Colors.amber,
                            );
                          }),
                        ),
                        const Gap(8),

                        Text(
                          '${date.toDateOnly()} days ago',

                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(12),
          Text(
            userComment,
            style: context.textTheme.bodyMedium?.copyWith(height: 1.4),
          ),
        ],
      ),
    );
  }
}

class ReviewInputSection extends StatelessWidget {
  const ReviewInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leave a Review',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(12),
        const StarRatingInput(),
        const Gap(12),
        TextFormField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Share your thoughts about this product...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colours.classicAdaptiveButtonOrIconColor(context),
              ),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
        const Gap(12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Submit Review',
              style: TextStyle(
                color: Colours.classicAdaptiveButtonOrIconColor(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StarRatingInput extends StatefulWidget {
  const StarRatingInput({super.key});

  @override
  State<StarRatingInput> createState() => _StarRatingInputState();
}

class _StarRatingInputState extends State<StarRatingInput> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Rating: ', style: context.textTheme.bodyLarge),
        const Gap(8),
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => setState(() => rating = index + 1),
              child: Icon(
                index < rating ? Icons.star : Icons.star_border,
                size: 30,
                color: Colors.amber,
              ),
            );
          }),
        ),
      ],
    );
  }
}
