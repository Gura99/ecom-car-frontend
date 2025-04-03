import 'package:crud/controllers/product_controller.dart';
import 'package:crud/pages/add_product.dart';
import 'package:crud/pages/list_product.dart';
import 'package:crud/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'first_page.dart'; // Import the new FirstPage file

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController controller = Get.put(ProductController());
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    FirstPage(), // First page with carousel and categories
    ListProduct(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => controller.fetchDataproduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0
            ? 'Welcome'
            : (_selectedIndex == 1 ? 'Our product' : 'Your Profile')),
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: (_selectedIndex == 0 ||
              _selectedIndex == 1) // Show FAB only on the Products page
          ? FloatingActionButton(
              onPressed: () {
                Get.to(() => AddProductPage());
              },
              child: Icon(Icons.add),
              tooltip: 'Add Product',
              mini: true,
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
