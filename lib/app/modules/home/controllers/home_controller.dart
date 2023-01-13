import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/product.dart';
import '../../../services/services.dart';

class HomeController extends GetxController {
  final products = <Product>[].obs;
  final itemToDisplay = <Product>[].obs;
  List<Product> itemFilterByName = <Product>[];
  List<Product> itemFilterByCategory = <Product>[];
  int initSum = 10;
  final filter = TextEditingController().obs;
  final isLoadingData = false.obs;
  final isAlreadyLoadAll = false.obs;
  bool isFilterByNameActive = false;
  bool isFilterByCategory = false;
  String categorySelected = 'All';

  final count = 0.obs;
  @override
  void onInit() async {
    products.value = await loadDataProducts();
    itemToDisplay.value = products.getRange(0, initSum).toList();
    super.onInit();
  }

  Future<List<Product>> loadDataProducts() async {
    List<Product>? data = await Services().getProductList();
    return data;
  }

  void filterData(String title, String type) async {
    if (type == 'name') {
      if (title != '') {
        itemToDisplay.value = products
            .where((product) =>
                product.title.toUpperCase().contains(title.toUpperCase()))
            .toList();
        itemFilterByName = itemToDisplay;
        isFilterByNameActive = true;
        isFilterByCategory = false;
        categorySelected = '';
      } else {
        itemToDisplay.value = products;
        isFilterByNameActive = false;
        isFilterByCategory = false;
        categorySelected = 'All';
      }
    } else {
      if (title != 'All') {
        categorySelected = title;
        itemToDisplay.value = products
            .where((product) =>
                product.category.toUpperCase().contains(title.toUpperCase()))
            .toList();
        itemFilterByCategory = itemToDisplay;
        isFilterByCategory = true;
        isFilterByNameActive = false;
      } else {
        itemToDisplay.value = products;
        isFilterByNameActive = false;
        isFilterByCategory = false;
        categorySelected = 'All';
      }
    }
  }

  void loadMore() async {
    if (isAlreadyLoadAll == false) {
      isLoadingData.value = true;
      await Future.delayed(const Duration(seconds: 1));
      isLoadingData.value = false;
      int end = initSum += 10;
      if (isFilterByNameActive) {
        if (end < itemFilterByName.length) {
          itemToDisplay.value = itemFilterByName.getRange(0, end).toList();
        } else {
          itemToDisplay.value =
              itemFilterByName.getRange(0, products.length).toList();
          isAlreadyLoadAll.value = true;
        }
        return;
      }
      if (isFilterByCategory) {
        if (end < itemFilterByCategory.length) {
          itemToDisplay.value = itemFilterByCategory.getRange(0, end).toList();
        } else {
          itemToDisplay.value =
              itemFilterByCategory.getRange(0, products.length).toList();
          isAlreadyLoadAll.value = true;
        }
        return;
      }
      if (end < products.length) {
        itemToDisplay.value = products.getRange(0, end).toList();
      } else {
        itemToDisplay.value = products.getRange(0, products.length).toList();
        isAlreadyLoadAll.value = true;
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
