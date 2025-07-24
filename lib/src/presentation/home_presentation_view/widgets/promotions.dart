import 'package:e_triad/core/res/media.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Promotions extends StatelessWidget {
  const Promotions({super.key});

  @override
  Widget build(BuildContext context) {
    return VxSwiper.builder(
      itemCount: 3,
      height: 100,
      scrollDirection: Axis.horizontal,
      scrollPhysics: PageScrollPhysics(),
      pauseAutoPlayOnTouch: Duration(seconds: 7),
      autoPlay: true,
      enableInfiniteScroll: true,

      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: switch (index) {
                0 => const AssetImage(Media.promo1),
                1 => const AssetImage(Media.promo2),
                _ => const AssetImage(Media.promo3),
              },
              fit: BoxFit.fitWidth,
            ),
          ),
        );
      },
    );
  }
}
