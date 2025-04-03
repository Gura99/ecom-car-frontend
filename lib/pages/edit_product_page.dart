import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crud/controllers/product_controller.dart';

class EditProductPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final ProductController productController = Get.find<ProductController>();

  EditProductPage({required this.product});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Pre-fill text fields with existing product details
    nameController.text = product['name'];
    descriptionController.text = product['description'];
    priceController.text = product['price'].toString();

    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateProduct();
              },
              child: Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProduct() {
    // Get the product ID from the product data
    int productId = product['id'];

    // Prepare the updated product data
    Map<String, dynamic> updatedProduct = {
      'name': nameController.text,
      'description': descriptionController.text,
      'price': double.tryParse(priceController.text) ?? 0.0,
    };

    // Call the updateProduct function in the controller

    productController.updateProduct(productId, updatedProduct);
  }
}
