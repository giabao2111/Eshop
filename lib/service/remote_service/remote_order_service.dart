import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eshop/const.dart';
import 'package:eshop/model/cart.dart';

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
