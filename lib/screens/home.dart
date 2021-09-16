import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_api/controllers/product_controller.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(child: Obx(() {
            if (productController.loading.value) {
              return Center(child: CircularProgressIndicator());
            }
            if (productController.products.isEmpty) {
              return Center(
                child: Text('NO PRODUCTS'),
              );
            }
            return _buildProductList();
          }))
        ],
      ),
    );
  }

  ListView _buildProductList() {
    return ListView.builder(
        itemCount: productController.products.length,
        itemBuilder: (context, index) => Card(
            elevation: 16.0,
            child: Container(
              height: 120,
              padding: EdgeInsets.all(9),
              margin: EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                productController.products[index]["image"]),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productController.products[index]['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          productController.products[index]["description"],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "\$${productController.products[index]["price"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )));
  }
}

AppBar _buildAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black),
    leading: Icon(Icons.menu),
    elevation: 2.0,
    title: Text(
      'My Shop App',
      style: TextStyle(color: Colors.blue),
    ),
    actions: [
      IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined))
    ],
  );
}
