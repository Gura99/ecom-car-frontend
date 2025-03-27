import 'package:crud/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteProductDialog {
  static void show(int productId) {
    Get.defaultDialog(
      title: "Delete Product",
      middleText: "Are you sure you want to delete this product?",
      onCancel: () {
        print('Delete canceled');
      },
      onConfirm: () {
        var controller =
            Get.find<ProductController>(); 
        controller.deleteProduct(productId); 
        Get.back(); 
      },
      textConfirm: "OK",
      textCancel: "Cancel",
      buttonColor: Colors.red, 
      confirmTextColor:
          Colors.white, 
    );
  }
}
