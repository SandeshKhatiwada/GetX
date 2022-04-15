// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/cart_controller.dart';
import 'package:getx/shopping_controller.dart';

class HomePage extends StatelessWidget {
  final shoppingController = Get.put(ShoppingController());
  final cartController =Get.put(CartController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("GetX"),
        centerTitle: true,
        elevation: 0,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetX<ShoppingController>(
                builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                    return Card(
                        margin: const EdgeInsets.all(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.products[index].productName,
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                          controller.products[index].productDescription),
                                    ],
                                  ),
                                  Text('\$${controller.products[index].price}',
                                      style: TextStyle(fontSize: 24)),
                                ],
                              ),
                              RaisedButton(
                                onPressed: () {
                                 cartController.addToCart(
                                   controller.products[index],
                                 );
                                },
                                color: Colors.blue,
                                textColor: Colors.white,
                                child: Text('Add to Cart'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  
                }
              ),
            ),
            GetX<CartController>(
              builder: (controller) {
                return Text("Total Amount: \$ ${controller.totalPrice} ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                );
              }
            ),
            SizedBox(height:200),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(onPressed: (){},
      icon: Icon(Icons.shopping_cart_sharp),
      backgroundColor: Colors.amber,
     label: GetX<CartController>(
       builder: (controller) {
         return Text(controller.count.toString(),
         style: TextStyle(
           fontSize: 20,
         ),
         );
       }
     ),
      ),
    );
  }
}