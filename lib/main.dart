import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:therapy_dashboard/Utils/Colors.dart';

import 'BottomNavigationBar/BottomNavigationBar.dart';
import 'MyBindings/Mybindings.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      defaultTransition: Transition.zoom,
          theme: Theme.of(context).copyWith(
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: vermelho,
                  statusBarIconBrightness: Brightness.light,
                  systemNavigationBarColor: vermelho,
                  systemNavigationBarIconBrightness: Brightness.light,
                ),
              ),
        ),
      home:BottomNavigationWidget(),
    );
  }
}
