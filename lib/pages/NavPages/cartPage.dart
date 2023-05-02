import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jibley/Models/Order.dart';

import '../OrderItem.dart';

class cartPage extends StatefulWidget {

  const cartPage({Key? key}) : super(key: key);

  @override
  State<cartPage> createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> orderStream;
  late String idUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idUser = FirebaseAuth.instance.currentUser!.uid;

    orderStream = FirebaseFirestore.instance.collection("Orders").snapshots();
  }
  Widget build(BuildContext context) {
    return  Scaffold(

        resizeToAvoidBottomInset: false,

        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: orderStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text("no data"));
                  }
                  final orders = snapshot.data!.docs
                      .map((doc) => Order_product.fromFirestore(doc))
                      .where((Order_product) {
                    return Order_product.idUser ==idUser;
                  })
                      .toList();
                  return Container(
                    padding: EdgeInsets.only(bottom: 16.0 ,left: 5,right: 5), // adjust bottom padding as needed
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing:0,
                        crossAxisSpacing: 0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  OrderItem(order: orders[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        )
    );
  }
}
