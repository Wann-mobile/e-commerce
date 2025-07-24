import 'package:e_triad/src/cart_product/presentation/cart_presentation_view/cart_view.dart';
import 'package:e_triad/src/presentation/explore_presentation_view/explore_view.dart';
import 'package:e_triad/src/presentation/home_presentation_view/home_view.dart';
import 'package:e_triad/src/presentation/profile_presentation/profile_view.dart';
import 'package:e_triad/src/wishlist/wishlisht_presentation_view/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

abstract class DashboardUtils {
  const DashboardUtils();

  static final scaffoldKey = GlobalKey<ScaffoldState>();
  static final iconList = <({IconData idle, IconData active})>[
    (idle: IconlyBroken.home, active: IconlyBold.home),
    (idle: IconlyBroken.discovery, active: IconlyBold.discovery),
    (idle: IconlyBroken.buy, active: IconlyBold.buy),
    (idle: IconlyBroken.heart, active: IconlyBold.heart),
    (idle: IconlyBroken.profile, active: IconlyBold.profile),
  ];
  static int activeIndex(GoRouterState state) {
    return switch (state.fullPath) {
      HomeView.path => 0,
      ExploreView.path => 1,
      CartView.path => 2,
      WishlistView.path => 3,
      ProfileView.path => 4,
      _ => 0,
    };
  }

  static final drawerItems = <({String title, IconData icon})>[
    (title: 'Profile', icon: IconlyBroken.profile),
    (title: 'Wishlist', icon: IconlyBroken.heart),
    (title: 'My orders', icon: IconlyBroken.time_circle),
    (title: 'Privacy Policy', icon: IconlyBroken.shield_done),
    (title: 'Terms & conditions', icon: IconlyBroken.document),
  ];
}
