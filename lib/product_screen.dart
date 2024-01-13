import 'package:cakeshop/cart_screen.dart';
import 'package:cakeshop/db_helper.dart';
import 'package:cakeshop/model/cart.dart';
import 'package:cakeshop/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  DBHelper? dbhelper = DBHelper();

  List<String> productName = ["Chochlate Cake", "Strawberry Cake"];
  List<String> weight = ["0.5", "0.5"];
  List<int> price = [279, 279];
  List<String> flavour = ["Chochlate", "Strawberry"];
  List<String> productImages = [
    'https://thefirstyearblog.com/wp-content/uploads/2015/11/chocolate-chocolate-cake-1.png',
    'https://www.delscookingtwist.com/wp-content/uploads/2023/05/Fraisier-Cake_French-Strawberry-Cake_1.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Cakes",
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            child: Center(
              child: badges.Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.getCounter().toString(),
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
                child: const Icon(Icons.cake_outlined),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productName.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  shadowColor: Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productName[index].toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rs. ${price[index].toString()}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Weight: ${weight[index].toString()} Kg",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    "Flavour: ${flavour[index].toString()}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      dbhelper!
                                          .insert(Cart(
                                        id: index,
                                        productId: index.toString(),
                                        productName:
                                            productName[index].toString(),
                                        initialPrice: price[index],
                                        finalPrice: price[index],
                                        quantity: 1,
                                        unitTag: weight[index].toString(),
                                        image: productImages[index].toString(),
                                        flavour: flavour[index].toString(),
                                      ))
                                          .then((value) {
                                        cart.addTotal(
                                          double.parse(
                                            price[index].toString(),
                                          ),
                                        );
                                        cart.addCounter();
                                      }).onError((error, stackTrace) {
                                        print(error);
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Text(
                                        "Add to Cart",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, top: 8, bottom: 8, right: 10),
                              child: Image(
                                alignment: Alignment.centerRight,
                                fit: BoxFit.fill,
                                height: 100,
                                width: 100,
                                image: NetworkImage(
                                  productImages[index].toString(),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  height: 50,
                  width: double.infinity,
                  child: const Text(
                    "Go to Cart",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
