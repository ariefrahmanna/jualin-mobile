// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

class SellItemsController extends GetxController {
  var items = <Item>[
    Item(
      title: "Kursi Kuning",
      price: "Rp 499.000",
      imagePath: "assets/images/keyboard.png",
      status: "Ready",
    ),
    Item(
      title: "Kursi Abu-abu",
      price: "Rp 999.000",
      imagePath: "assets/images/keyboard.png",
      status: "Sold Out",
    ),
  ].obs;

  void addItem(Item item) {
    items.add(item);
  }

  void updateItemStatus(int index, String newStatus) {
    items[index].status = newStatus;
    update();
  }

  @override
  void onInit() {
    super.onInit();
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

class Item {
  final String title;
  final String price;
  final String imagePath;
  String status;

  Item({
    required this.title,
    required this.price,
    required this.imagePath,
    this.status = "Ready",
  });
}
