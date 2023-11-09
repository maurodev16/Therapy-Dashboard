import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapy_dashboard/Utils/Colors.dart';

import '../Controller/BottomNavigationController.dart';

class BottomNavigationWidget extends GetView<BottomNavigationController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          body: controller.pages[controller.currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.changePage(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    Icon(
                      Icons.euro,
                    ),
                  ],
                ),
                label: 'Bills',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month,
                ),
                label: 'Appointment',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
            selectedItemColor: azul,
            unselectedItemColor: Colors.grey,
            elevation: 0,
            showSelectedLabels: false,
          ),
        );
      },
    );
  }
}
