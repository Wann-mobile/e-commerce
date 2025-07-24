import 'package:e_triad/core/common/user_related_entities/address.dart';
import 'package:e_triad/src/wishlist/domain/entities/wishlist_product.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User( {
    required this.id,
    required this.name,
    required this.email,
    this.isAdmin = false,
    this.wishlist = const [],
    this.address,
    this.phone,
    this.cartProductIds = const [],
  });

  const User.empty()
    : id = 'Test Id',
      name = 'Test Name',
      email = 'Test Email',
      isAdmin = true,
      wishlist = const [],
      address = null,
      phone = null,
      cartProductIds = const [''];

  final String id;
  final String name;
  final String email;
  final bool isAdmin;
  final List<Wishlist> wishlist;
  final Address? address;
  final String? phone;
  final List<String> cartProductIds;

  @override
  List<Object?> get props => [id, name, email, isAdmin, wishlist.length,cartProductIds];
}
