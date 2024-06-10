import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eshop/const.dart';
import 'package:eshop/model/cart.dart';

import '../../model/order.dart';

Future<bool> checkout(String email, Cart cart) async {
  final String apiUrl = '$baseUrl/api/orders/$email'; // Tạo URL cho API checkout

  try {
    final jsonUtf8 = jsonEncode(cart.toJson()).codeUnits;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:  jsonEncode(cart.toJson()), // Mã hóa chuỗi JSON thành một mảng byte
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // Thành công
      return true;
    } else {
      throw Exception('Failed to checkout: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to checkout: $e');
  }
}
Future<List<Order>> getOrderList(String email) async {
  String apiUrl = '$baseUrl/api/orders/user/$email';

  final response = await http.get(Uri.parse(apiUrl));
  print(response.statusCode);
  if (response.statusCode == 200) {
    final decodedBody = utf8.decode(response.bodyBytes);
    List<dynamic> jsonResponse = json.decode(decodedBody);
    return jsonResponse.map((order) => Order.fromJson(order as Map<String, dynamic>)).toList();
  } else {
    throw Exception('Failed to load orders');
  }
}
