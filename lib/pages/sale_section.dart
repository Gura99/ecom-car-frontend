import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crud/controllers/product_controller.dart';
import 'package:crud/pages/list_product.dart';

class SaleSection extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  SaleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "For Sale Auction",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => ListProduct());
              },
              child: const Text("View all →",
                  style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Obx(() {
          if (productController.products.isEmpty) {
            return const Center(child: Text("No products available."));
          }
          final limitedProducts = productController.products.take(5).toList();
          return Column(
            children: limitedProducts.map((product) {
              String imageUrl = product['image'].toString();

              if (imageUrl.contains("https://i.ibb.co")) {
                imageUrl =
                    imageUrl.substring(imageUrl.indexOf("https://i.ibb.co"));
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: imageUrl.isEmpty
                          ? Image.network(
                              "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png", // Default fallback image
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imageUrl,
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(
                                  Icons.broken_image,
                                  size: 80,
                                  color: Colors.grey),
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'].toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            product['description'].toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\$ ${product['price'].toString()}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.favorite_border, color: Colors.purple),
                  ],
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
