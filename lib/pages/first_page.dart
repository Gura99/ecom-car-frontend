import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crud/pages/sale_section.dart';
import 'package:crud/pages/slider.dart';
import 'package:crud/pages/search_vehicle_section.dart';
import 'package:crud/controllers/product_controller.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> vehicleTypes = [
    {"name": "Car", "isActive": true},
    {"name": "Motor Cycle", "isActive": false},
    {"name": "Bus", "isActive": false},
    {"name": "Vegans", "isActive": false},
  ];

 
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchVehicleSection(vehicleTypes: vehicleTypes),
            const SizedBox(height: 20),
            ForSlider(),
            const SizedBox(height: 20),
            SaleSection(), // No need to pass carsForSale, it fetches from ProductController
          ],
        ),
      ),
    );
  }
}
