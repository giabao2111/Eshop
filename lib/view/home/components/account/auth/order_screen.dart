import 'package:eshop/controller/controllers.dart';
import 'package:eshop/model/order.dart';
import 'package:eshop/service/remote_service/remote_order_service.dart';
import 'package:flutter/material.dart';

class OrderListScreen extends StatefulWidget {
  final String email;

  OrderListScreen({required this.email});

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late Future<List<Order>> _orderListFuture;
  @override
  void initState() {
    super.initState();
    _orderListFuture = getOrderList(authController.user.value!.email);
  }
  String getStatusText(int status) {
    switch (status) {
      case 0:
        return 'Chờ xác nhận';
      case 1:
        return 'Đang giao hàng';
      case 2:
        return 'Đã giao';
      default:
        return 'Trạng thái không xác định';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách đơn hàng'),
      ),
      body: FutureBuilder<List<Order>>(
        future: _orderListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('Đã xảy ra lỗi: ${snapshot.error}'),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('Không có đơn hàng nào'));
          } else {
            // Hiển thị danh sách đơn hàng
             return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Order order = snapshot.data![index];
                return Column(
                  children: [
                    ListTile(
                      title: Text('Mã đơn hàng #${order.ordersId}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ngày đặt hàng: ${order.orderDate.toLocal().toString().split(' ')[0]}'),
                          Text('Tổng tiền: ${order.amount}'),
                          Text('Số điện thoại: ${order.phone}'),
                          Text('Trạng thái: ${getStatusText(order.status)}'),
                        ],
                      ),
                    ),
                    Divider(), // Đường kẻ giữa các đơn hàng
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
