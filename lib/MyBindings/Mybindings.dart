import 'package:get/get.dart';
import 'package:therapy_dashboard/IRepository/IRepositoryUser.dart';
import 'package:therapy_dashboard/Repository/RepositoryUser.dart';

import '../Controller/AppointmentController.dart';
import '../Controller/BillsController.dart';
import '../Controller/BottomNavigationController.dart';
import '../Controller/ClientListPageController.dart';
import '../Controller/HomeController.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() { 
    Get.put(AppointmentController());
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<BillsController>(() => BillsController());
    Get.lazyPut<ClientListController>(() => ClientListController(Get.find()));

    /// REPOSITORIES
    Get.lazyPut<IRepositoryUser>(() => RepositoryUser());
  }
}
