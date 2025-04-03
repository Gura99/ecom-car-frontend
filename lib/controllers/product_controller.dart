import 'package:crud/config/app_config.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  var products = <dynamic>[].obs;
  final dio.Dio dioClient = dio.Dio();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  var selectedImage = Rx<File?>(null); // Store selected image

  @override
  void onInit() {
    super.onInit();
    fetchDataproduct();
  }

  /// Select Image from Gallery
  Future<void> selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  /// Fetch Products from API
  Future<void> fetchDataproduct() async {
    try {
      final response = await dioClient.get('${AppConfig.baseUrl}/product');

      if (response.statusCode == 200) {
        debugPrint('Response Data: ${response.data}');
        if (response.data['data'] != null && response.data['data'] is List) {
          products.assignAll(response.data['data']);
        } else if (response.data is List) {
          products.assignAll(response.data);
        } else {
          debugPrint('Unexpected response format');
        }
      } else {
        debugPrint(
            'Failed to fetch products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
    }
  }

  /// Add New Product
  Future<void> addProduct(Map<String, dynamic> product, File imageFile) async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'name': product['name'],
        'description': product['description'],
        'price': product['price'].toString(),
        'image': await dio.MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      var response = await dioClient.post(
        '${AppConfig.baseUrl}/product',
        data: formData,
        options: dio.Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Product added successfully');
        await fetchDataproduct();
      } else {
        Get.snackbar('Error', 'Failed to add product');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  /// Update Existing Product
  Future<void> updateProduct(
      int productId, Map<String, dynamic> updatedProduct) async {
    try {
      var response = await dioClient.put(
        '${AppConfig.baseUrl}/product/$productId',
        data: updatedProduct,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Product updated successfully',
            snackPosition: SnackPosition.BOTTOM);
        await fetchDataproduct();
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to update product',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          snackPosition: SnackPosition.TOP);
    }
  }

  /// Delete Product
  Future<void> deleteProduct(int productId) async {
    try {
      var response =
          await dioClient.delete('${AppConfig.baseUrl}/product/$productId');

      if (response.statusCode == 200) {
        debugPrint('Product deleted successfully');
        await fetchDataproduct();
      } else {
        debugPrint('Failed to delete product. Status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error deleting product: $e');
    }
  }

  /// Show Delete Confirmation Dialog
  void deleteProductDialog(int productId) {
    Get.defaultDialog(
      title: "Delete Product",
      middleText: "Are you sure you want to delete this product?",
      onCancel: () {
        debugPrint('Delete canceled');
      },
      onConfirm: () {
        deleteProduct(productId);
        Get.back();
      },
      textConfirm: "OK",
      textCancel: "Cancel",
      buttonColor: Colors.red,
      confirmTextColor: Colors.white,
    );
  }
}
