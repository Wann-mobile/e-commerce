import 'package:e_triad/src/orders/domain/entity/orders.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.status,
    required super.dateOrdered,
    required super.totalPrice,
    required super.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? json['_id'],
      status: json['status'],
      dateOrdered: json['dateOrdered'],
      totalPrice: json['totalPrice'],
      orderItems: (json['orderItems'] as List).map((e) {
        return OrderItemEntity(
          id: e['id'] ?? e['_id'],
          productName: e['productName'],
          productImage: e['productImage'],
        );
      }).toList(),
    );
  }
}