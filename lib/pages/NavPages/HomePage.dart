

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

import 'package:mj_image_slider/mj_options.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jibley/Models/User.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:mj_image_slider/mj_image_slider.dart';
import 'package:flutter_svg/svg.dart';

import '../../Models/Product.dart';
import '../../Services/authController.dart';
import '../../constants.dart';
import '../../Product/productItem.dart';

class homePage extends StatefulWidget {
  String? uid1;

  homePage({Key? key, required uid1}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  FixedHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        // Content that can be scrolled
        Positioned(
          top: 10,
          left: 5,
          right: 5,
          bottom: 10,
          child: SizedBox(
            height: 20,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              height: maxExtent,
              margin: EdgeInsets.only(top: maxTop),
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  double get maxTop => 0;

  @override
  double get minTop => 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _homePageState extends State<homePage> with TickerProviderStateMixin {
  late Stream<DocumentSnapshot> userStream;
  late var selectedProductIndex;

  late Stream<QuerySnapshot<Map<String, dynamic>>> productStream;
  late TabController _tabController;
  ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;

  /*late Stream<QuerySnapshot> productStream;
  late Stream<List<dynamic>> productUserStream;
  late Stream<List<dynamic>> productUserListStream;*/

  List<String> images = [
    "assets/images/images_1.jpg",
    "assets/images/images_2.jpg",
    "assets/images/images_3.jpg",
    "assets/images/images_4.jpg",
  ];
  List<String> networkImages = [
    "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1176&q=80",
    "https://images.unsplash.com/photo-1546587348-d12660c30c50?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1174&q=80",
    "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
    "https://images.unsplash.com/photo-1525127752301-99b0b6379811?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    userStream =
        FirebaseFirestore.instance.collection('Users').doc(uid).snapshots();
    productStream = FirebaseFirestore.instance.collection("Foods").snapshots();
    _tabController = TabController(length: 3, vsync: this);
    selectedProductIndex = 0;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 &&
          _scrollController.offset <
              _scrollController.position.maxScrollExtent) {
        if (!_animationController.isAnimating) {
          _animationController.forward();
        }
      } else {
        if (_animationController.isAnimating) {
          _animationController.reverse();
        }
      }
    });

    /*final productUserStream = rxdart.Rx.combineLatest2(
      productStream,
      userStream,
          (productSnapshot, userSnapshot) =>
      [productSnapshot.docs, userSnapshot.data()],
    );*/
    /* productUserListStream = productUserStream.map((data) {
      final productDocs = data[0] as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
      final userDoc = data[1] as DocumentSnapshot<Map<String, dynamic>>;
      final user = UserMe.fromMap(userDoc.data()!);
      final products = productDocs.map((doc) => Product.fromMap(doc.data())).toList();
      return [user, products];
    });
*/
  }

  void dispose() {
    _animationController.dispose();

    selectedProductIndex.dispose();
    super.dispose();
  }

  // get uid => uid;
  //String name = '';
  /* void initState() {
    super.initState();
   // getData(uid);
  }*/

  /* void getData(uid) async {
    if (uid != null||name != null) {
      DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('users').child(uid);
      DataSnapshot snapshot = (await dbRef.once()).snapshot;
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      if (data!= null)
      // Use the data here.
      setState(() {
        name = data['name'];

      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
          stream: userStream,
          builder: (context, snapshot1) {
            if (!snapshot1.hasData) {
              return const Center(child: Text("no data"));
            } else if (snapshot1.hasData) {
              UserMe user = UserMe.fromMap(
                  snapshot1.data!.data()! as Map<String, dynamic>);
              {
                return SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(

                        forceElevated: true,
                        automaticallyImplyLeading: true,
                        expandedHeight: 0,
                        backgroundColor: Colors.white,
                        centerTitle: false,
                        title: SvgPicture.asset(
                          'assets/images/ic_instagram.svg',
                          color: Colors.blueAccent,
                          height: 32,
                        ),
                        actions: [
                          Row(
                            children: [
                              Container(
                                //margin: EdgeInsets.only(top: 30,left: 20),
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 20,
                                ),
                                width: w,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Column(

                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Hello Welcome 👋",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.black87,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                            "${user.name}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.black87,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal),
                                          ),

                                        ],
                                      ),
                                    ),
                                    SearchBarAnimation(

                                      textEditingController: TextEditingController(),
                                      enableButtonBorder: false,
                                      enableButtonShadow: false,
                                      hintText: 'Search Items',
                                      inputFormatters:  <TextInputFormatter> [
                                        LengthLimitingTextInputFormatter(20)
                                      ],
                                      textAlignToRight: false,
                                      isSearchBoxOnRightSide: true,
                                      textInputType: TextInputType.text,
                                      searchBoxWidth: 210,
                                      isOriginalAnimation: false,
                                      enableKeyboardFocus: true,
                                      onExpansionComplete: () {
                                        debugPrint(
                                            'do something just after searchbox is opened.');
                                      },
                                      onCollapseComplete: () {

                                        debugPrint(
                                            'do something just after searchbox is closed.');
                                      },
                                      onPressButton: (isSearchBarOpens) {
                                        debugPrint(
                                            'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
                                      },
                                      trailingWidget: const Icon(
                                        Icons.search,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      secondaryButtonWidget: const Icon(
                                        Icons.close,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                      buttonWidget: const Icon(
                                        Icons.search,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ),



                                    /* Container(

                              width: w*0.2,
                              height: h*0.2,

                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(200),
                                image: DecorationImage(

                                    fit: BoxFit.fitWidth,
                                    image: AssetImage(

                                        'assets/images/logo3.png',


                                    )

                                ),

                              ),

                            )*/
                                  ],
                                ),
                              ),

                            ],
                          ),

                        ],
                        floating: true,
                        // Désactive l'effet de disparition de la barre d'applications
                        pinned:
                            false, // Épingle la barre d'applications en haut de l'écran
                      ),

                      SliverToBoxAdapter(
                        child: Container(
                            height: h * 0.28,
                            width: w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Carousel(
                              scrollAxis: Axis.horizontal,
                              indicatorBarColor: Colors.black.withOpacity(0),
                              autoScrollDuration: Duration(seconds: 2),
                              animationPageDuration: Duration(milliseconds: 500),
                              activateIndicatorColor: Colors.black,

                              animationPageCurve: Curves.linear,
                              indicatorBarHeight: 40,
                              indicatorHeight: 10,
                              indicatorWidth: 5,
                              unActivatedIndicatorColor: Colors.black38,
                              stopAtEnd: false,
                              autoScroll: true,
                              // widgets
                              items: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/foods.jpeg',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          'assets/images/food24.jpeg',
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/food26.jpeg',
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                        'assets/images/food27.jpeg',
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: FixedHeaderDelegate(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 2.0,
                                    blurRadius: 3.0,
                                    offset: Offset(0, 2),
                                  ),
                                ]),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TabBar(
                                        onTap: (index) {
                                          setState(() {
                                            _tabController.index = index;
                                          });
                                        },
                                        indicatorWeight: 5,
                                        labelColor: Colors.black,
                                        unselectedLabelColor: Colors.black38,
                                        indicator: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.amber,
                                        ),
                                        labelStyle: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        isScrollable: true,
                                        controller: _tabController,
                                        tabs: [
                                          Tab(
                                            text: "All",
                                          ),
                                          Tab(
                                            text: "pizza",
                                          ),
                                          Tab(
                                            text: "Burgers",
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    width: 80,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // handle filter button press
                                    },
                                    icon: Icon(Icons.edit_note),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: productStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData) {
                              return Center(child: Text("no data"));
                            }
                            final products = snapshot.data!.docs
                                .map((doc) => Product.fromFirestore(doc))
                                .where((product) {
                              if (_tabController.index == 0) {
                                return true; // show all products
                              } else if (_tabController.index == 1) {
                                return product.catygorie ==
                                    "Pizza"; // show pizza products
                              } else if (_tabController.index == 2) {
                                return product.catygorie ==
                                    "Burgers"; // show burger products
                              } else {
                                return false; // don't show anything
                              }
                            }).toList();
                            products.shuffle();
                            return Container(
                              padding: EdgeInsets.only(
                                  bottom: 16.0, left: 5, right: 5),
                              // adjust bottom padding as needed
                              child: AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(
                                        0, _animationController.value * 200),
                                    child: child,
                                  );
                                },
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    // number of grid columns
                                    mainAxisSpacing: 16.0,
                                    // space between rows
                                    crossAxisSpacing: 16.0,
                                    // space between columns
                                    childAspectRatio:
                                        0.75, // aspect ratio of grid items
                                  ),
                                  itemCount: products.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedProductIndex = index;
                                          });
                                        },
                                        child: ProductItem(
                                          products: products,
                                          selected: selectedProductIndex == index,
                                          index: index,
                                        ));
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      )

                      /*SliverPersistentHeader(
                  pinned: true,

                  delegate: FixedHeaderDelegate(

                      child:  Container(
                        decoration: BoxDecoration(
                            color: Colors.white ,
                          borderRadius: BorderRadius.circular(30,),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 2.0,
                              blurRadius: 3.0,
                              offset: Offset(0, 2),
                            ),
                          ]
                        ),

                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TabBar(

                                indicatorWeight: 5,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.black38,
                                indicator: BoxDecoration(

                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.amber,



                                ),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                                isScrollable: true,
                                controller: _tabController,
                                tabs: [
                                  Tab(text: "All",),
                                  Tab(text: "pizza",),
                                  Tab(text: "Burgers",),
                                ]

                            ),
                          ),
                        ) ,
                      ), ),
              ),

              SliverToBoxAdapter(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: productStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData) {
                        return Center(child: Text("no data"));
                      }
                      final products = snapshot.data!.docs.map((doc) => Product.fromFirestore(doc)).toList();
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // number of grid columns
                          mainAxisSpacing: 16.0, // space between rows
                          crossAxisSpacing: 16.0, // space between columns
                          childAspectRatio: 0.75, // aspect ratio of grid items
                        ),
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductItem(product: products[index]);
                        },
                      );
                    },
                  ),
              )*/
                      /*SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: productStream,
                            builder:(context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> productSnapshot){
                            if (productSnapshot.error != null){
                              return Center(
                                child: CircularProgressIndicator(),
                              );

                            }
                            if(!productSnapshot.hasData){
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            List<Product> products = productSnapshot.data!.docs.map((doc) {
                              return Product.fromFirestore(doc);
                            }).toList();
                            return SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  return ProductItem(product: products[index]);
                                },
                                childCount: products.length,
                              ),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // number of grid columns
                                mainAxisSpacing: 16.0, // space between rows
                                crossAxisSpacing: 16.0, // space between columns
                                childAspectRatio: 0.75, // aspect ratio of grid items
                              ),
                            );
                            },
                        )


                      ],
                    ),
                  ),
              ),*/

                      /*Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: GridView.builder(
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: kDefaultPaddin,
                          crossAxisSpacing: kDefaultPaddin,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) => ItemCard(
                          product: products[index],
                          press: () {},
                        )),
                  ),
             ),*/

                      /* GestureDetector(
                  onTap: () {
                    AuthController().logout();
                  },
                  child: Container(
                    width: w * 0.5,
                    height: h * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/logo3.png'
                          )

                      ),

                    ),
                    child: Center(
                      child: const Text("Signe out",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'
                        ),
                      ),
                    ),

                  ),
              ),*/
                    ],
                  ),
                );
              }
              /* Map<String, dynamic> data = snapshot1.data!.data() as Map<
            String,
            dynamic>;
        return Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20,),
                  padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                  width: w,
                  height: h * 0.3,
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello Welcome 👋 "
                        , textAlign: TextAlign.center,

                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AuthController().logout();
                        },
                        child: Container(
                          width: w * 0.5,
                          height: h * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/images/logo.png'
                                )

                            ),

                          ),
                          child: Center(
                            child: const Text("Signe out",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'
                              ),
                            ),
                          ),

                        ),
                      ),
                    ],
                  )
                  ,
                ),
              ],
            )
          ],

        );*/
            } else
              return Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 300,
                  ),
                  CircularProgressIndicator(),
                  GestureDetector(
                    onTap: () {
                      AuthController().logout();
                    },
                    child: Container(
                      width: w * 0.5,
                      height: h * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/logo2.png')),
                      ),
                      child: Center(
                        child: const Text(
                          "Signe out",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed logic here
        },
        child: Icon(
          Icons.shopping_cart,
          color: Colors.black,
        ),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
