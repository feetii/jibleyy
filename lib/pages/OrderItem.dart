import 'package:flutter/material.dart';
import 'package:jibley/Models/Order.dart';

class OrderItem extends StatelessWidget {
  final Order_product order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text("Address: ${order.adresse}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quantity: ${order.quantity}"),
            Text("Phone number: ${order.numero}"),
          ],
        ),
      ),
    );
  }
}