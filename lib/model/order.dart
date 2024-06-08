import 'package:eshop/model/user.dart';

class Order {
  final int ordersId;
  final DateTime orderDate;
  final double amount;
  final String address;
  final String phone;
  final int status;
  final User user;

  Order({
    required this.ordersId,
    required this.orderDate,
    required this.amount,
    required this.address,
    required this.phone,
    required this.status,
    required this.user,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      ordersId: json['ordersId'] as int, // Chuyển đổi sang kiểu int
      orderDate: DateTime.parse(json['orderDate'] as String), // Chuyển đổi sang kiểu DateTime
      amount: (json['amount'] as num).toDouble(), // Chuyển đổi sang kiểu double
      address: json['address'] as String,
      phone: json['phone'] as String,
      status: json['status'] as int, // Chuyển đổi sang kiểu int
      user: User.fromJson(json['user'] as Map<String, dynamic>), // Chuyển đổi sang kiểu Map<String, dynamic>
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ordersId': ordersId,
      'orderDate': orderDate.toIso8601String(),
      'amount': amount,
      'address': address.toString(),
      'phone': phone,
      'status': status,
      'user': user.toJson(),
    };
  }
}