

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jibley/Product/AddOrder.dart';
import 'package:jibley/Models/Product.dart';
import 'package:jibley/pages/NavPages/HomePage.dart';
import 'package:jibley/pages/NavPages/navho.dart';

class ProductDetails extends StatefulWidget {
  final List<Product> products;
  final int index;


  const ProductDetails({Key? key, required this.products,required this.index}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _quantity = 1;
  bool isFavorited = false;
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);


    void toggleFavorite() {
      setState(() {
        isFavorited = !isFavorited;
      });
    }
    void incrementQuantity() {
      setState(() {
        _quantity++;
      });
    }

    void decrementQuantity() {
      setState(() {
        if (_quantity > 1) {
          _quantity--;
        }
      });
    }
    void addToCart() {
      // Implement your cart state management here.
      // You can use a library like GetX or Provider to manage the cart state.
      // For example, you can add the current product and its quantity to a list of cart items.
      // Then, navigate to the cart screen to display the cart items.
      String idUser = FirebaseAuth.instance.currentUser!.uid;
      Get.snackbar("about User", "user messege",
          snackPosition: SnackPosition.BOTTOM,

          titleText: const Text('Cart',
            style: TextStyle(

              color: Colors.black,
            ),
          ),
          messageText: const Text('Product add to cart' ,style: TextStyle(
              color: Colors.black
          ),
          )

      );
     Get.to(() => AddOrder( product: widget.products[widget.index] ,));
      /*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product added to cart!'),
          duration: Duration(seconds: 4),
          action: SnackBarAction(
            label: 'View cart',
            onPressed: () {
              // Navigate to the cart screen.
            },
          ),
        ),
      );*/

    }
    Widget buildFloatingActionButton() {
      return FloatingActionButton.extended(
        onPressed: addToCart,
        icon: const Icon(Icons.shopping_cart),
        label: const Text('Add to Cart'),
        backgroundColor: Colors.amber,
        elevation: 50,
        enableFeedback: true,
        autofocus: true,
        extendedIconLabelSpacing: 20,
        isExtended: true,
        splashColor: Colors.black,
        focusColor: Colors.black,

      );
    }
    return Scaffold(
      backgroundColor: Colors.white,

      body:SingleChildScrollView (
        child: Column(
          children: [


            Container(

              height:300,
              child: Stack(

                children: [



                  Expanded(
                      flex: 1,
                      child: Container(

                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/backgroun.jpg"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(120),
                                bottomRight: Radius.circular(120)
                            ),
                            border: Border(
                              bottom: BorderSide(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            color: Colors.amber
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(

                        padding: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/images/backgroun.jpg"),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white10),
                            color: Colors.amber
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Container(

                        padding: const EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/images/backgroun.jpg"),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white10),
                            color: Colors.amber
                        ),

                        child: IconButton(
                          icon: Icon(
                            isFavorited ? Icons.favorite : Icons.favorite_border,
                            color: isFavorited ? Colors.red :Colors.black,
                          ),
                          onPressed: toggleFavorite,
                        ),
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: FractionalTranslation(
                        translation: const Offset(0.0, -0.4),
                        child: Text(
                            widget.products[widget.index].title,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            height: 2,
                            letterSpacing: 1.0,
                            overflow: TextOverflow.fade,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 1.0,
                              )
                            ],

                          ),
                        ),
                      )
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionalTranslation(
                      translation: const Offset(0.0, 0.4),
                      child: ClipOval(
                        child: Image.network(widget.products[widget.index].image,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,),

                      ),
                    ),
                  )

                ],

              ),
            ),
            const SizedBox(height:80,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child:Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: int.parse(widget.products[widget.index].discount) > 0 ? ((double.parse(widget.products[widget.index].price) - (double.parse(widget.products[widget.index].price) * int.parse(widget.products[widget.index].discount) / 100))*_quantity).toStringAsFixed(2) + ' DA' : widget.products[widget.index].price.toString() + ' DA',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,

                            color: Colors.black,
                          ),
                        ),
                        if (int.parse(widget.products[widget.index].discount) > 0) ...[
                          const TextSpan(text: '  '),
                          TextSpan(
                            text: '${(double.parse(widget.products[widget.index].price)*_quantity).toStringAsFixed(2) } DA',
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.black38,
                              decorationThickness: 2.0,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(

                      color: Colors.black12,
                      width: 2.0,
                    ),
                    color: Colors.black12,
                  ),

                  margin: const EdgeInsets.all(20),
                  child:Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          decrementQuantity();
                        },
                      ),
                      Container(
                        height:30 ,
                        width: 30,
                        decoration: BoxDecoration(

                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white10),
                            color: Colors.amber
                        ),
                        child: Center(
                          child: Text('$_quantity',style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 2,

                          ), ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          incrementQuantity();
                        },
                      ),
                    ],
                  )
                )
              ],
            ),
            Container(

              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(

                  color: Colors.black12,
                  width: 2.0,
                ),
                color: Colors.orange[100],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text('Rating',style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w100,
                        height: 1,
                        letterSpacing: 1.0,


                      ),),
                      Row(
                        children: const [
                          Icon(
                            Icons.star,
                            color: Colors.amber,size: 30,

                          ),
                         Text('4.9',style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 2,

                          ), ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Energy',style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w100,
                        height: 1,
                        letterSpacing: 1.0,


                      ),),
                      Row(
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            color: Colors.orange[900],size: 30,

                          ),
                          const Text('296 Cal',style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 2,

                          ), ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Delivery In',style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w100,
                        height: 1,
                        letterSpacing: 1.0,


                      ),),
                      Row(
                        children: const [
                          Icon(
                            Icons.alarm,
                            color: Colors.amber,size: 30,

                          ),
                          Text('30 min',style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 2,

                          ), ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: w,
              child: Column(
                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      letterSpacing: 1.0,



                    ),
                  ),
                  Text(
                    widget.products[widget.index].description,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      height: 2,
                      letterSpacing: 1.0,
                      color: Colors.black54
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
