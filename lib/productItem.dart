import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jibley/pages/ProductDetails.dart';
import 'package:jibley/pages/SignIn.dart';
import 'package:jibley/pages/tsss2.dart';

import 'Models/Product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final bool selected; // add this

  const ProductItem({Key? key, required this.product,this.selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(   duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(selected ? 12.0 : 8.0),
        border: Border.all(
          color: selected ? Colors.white10 : Colors.transparent,
          width: selected ? 5.0 : 0.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius:10,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: GestureDetector(
        onTap:()=>Get.to(()=>ProductDetails(product: product)) ,
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(product.image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.darken,
              ),
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200.0,
                        ),
                      ),
                    ),
                    Visibility(
                      visible:int.parse(product.discount) > 0,
                      child: Positioned(
                        top: 5.0,
                        right: 5.0,
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            '${product.discount}% OFF',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                product.title,
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 4.0),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${int.parse(product.discount) > 0 ? (double.parse(product.price) - (double.parse(product.price) * int.parse(product.discount) / 100)).toStringAsFixed(2) + ' DA' : product.price.toString() + ' DA'}',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (int.parse(product.discount) > 0) ...[
                      TextSpan(text: '  '),
                      TextSpan(
                        text: '${product.price} DA',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.white,
                          decorationThickness: 2.0,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ],
                  ],
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
