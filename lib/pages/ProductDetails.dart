import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jibley/AddOrder.dart';
import 'package:jibley/Models/Product.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Hero(
                  tag: widget.product.image,
                  child: Image.network(
                    widget.product.image,
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: theme.primaryColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    widget.product.title,
                    style: theme.textTheme.headline5,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '${widget.product.price} DA',
                    style: theme.textTheme.headline6,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Description',
                    style: theme.textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.product.description,
                    style: theme.textTheme.bodyText1?.copyWith(
                      color: theme.disabledColor,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Quantity',
                    style: theme.textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: _quantity > 1 ? theme.primaryColor : theme.disabledColor,
                        ),
                        onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                      ),
                      Text(
                        '$_quantity',
                        style: theme.textTheme.headline6,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: theme.primaryColor,
                        ),
                        onPressed: () => setState(() => _quantity++),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed:()=>Get.to(()=>AddOrder(product: widget.product)),
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
