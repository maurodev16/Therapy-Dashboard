import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapy_dashboard/Pages/BottonNavPages/BillsPage.dart';
import 'package:therapy_dashboard/Pages/BottonNavPages/ClientListPage.dart';

import '../Pages/BottonNavPages/HomePage.dart';
import '../Pages/BottonNavPages/SettingsPage.dart';

class BottomNavigationController extends GetxController {
  static BottomNavigationController get to => Get.find();
  var currentIndex = 0.obs;

  List<Widget> pages = [
    HomePage(),
    BillsPage(),
    ClientListPage(),
    SettingsPage(),
  ].obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
