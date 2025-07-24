class OrderEntity {
  final String id;
  final String status;
  final String dateOrdered;
  final int totalPrice;
  final List<OrderItemEntity> orderItems;

  OrderEntity({
    required this.id,
    required this.status,
    required this.dateOrdered,
    required this.totalPrice,
    required this.orderItems,
  });
}

class OrderItemEntity {
  final String id;
  final String productName;
  final String productImage;

  OrderItemEntity({
    required this.id,
    required this.productName,
    required this.productImage,
  });
}