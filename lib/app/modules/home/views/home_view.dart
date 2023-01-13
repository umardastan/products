import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  TextEditingController filter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          // backgroundColor: Colors.white,
          leading: const Icon(Icons.arrow_back, color: Colors.black),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 40,
              child: TextFormField(
                controller: filter,
                onChanged: (value) {
                  controller.filterData(value, 'name');
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    filled: true,
                    fillColor: Colors.grey.shade100),
              ),
            ),
            const Icon(Icons.shopping_cart),
            const Icon(Icons.menu)
          ]),
        ),
        body: Obx(
          () => controller.itemToDisplay.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : NotificationListener<ScrollEndNotification>(
                  onNotification: (ScrollEndNotification notification) {
                    if (notification.metrics.extentAfter == 0) {
                      controller.loadMore();
                    }
                    return true;
                  },
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      CategoryItem(
                                        title: 'All',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      CategoryItem(
                                        title: 'Smartphones',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      CategoryItem(
                                        title: 'Laptops',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      CategoryItem(
                                        title: 'Fragrances',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      CategoryItem(
                                        title: 'Skincare',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      CategoryItem(
                                        title: 'Groceries',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      CategoryItem(
                                        title: 'home-decoration',
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          Expanded(
                            child: MasonryGridView.count(
                              itemCount: controller.itemToDisplay.length,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[100]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(controller
                                              .itemToDisplay[index].thumbnail)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          controller.itemToDisplay[index].brand,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        controller.itemToDisplay[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(controller
                                          .itemToDisplay[index].description),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          NumberFormat.currency(
                                            locale: 'en-US',
                                            decimalDigits: 0,
                                          ).format(controller
                                              .itemToDisplay[index].price),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          'Stok : ${controller.itemToDisplay[index].stock.toString()}'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(controller
                                          .itemToDisplay[index].category),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      // ignore: unrelated_type_equality_checks
                      controller.isLoadingData == true
                          ? Positioned(
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                width: MediaQuery.of(context).size.width,
                                child:
                                    const Center(child: CircularProgressIndicator()),
                              ))
                          : Container()
                    ],
                  ),
                ),
        ));
  }
}

class CategoryItem extends GetView<HomeController> {
  String title;
  CategoryItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.filterData(title, 'category');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Center(child: Text(title)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 2, color : controller.categorySelected == title ? Colors.grey.shade600 : Colors.grey.shade200),
            color: Colors.grey[100]),
      ),
    );
  }
}
