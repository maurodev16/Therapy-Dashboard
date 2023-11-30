import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:upgrader/upgrader.dart';

import 'BottomNavigationBar/BottomNavigationBar.dart';
import 'Controller/AuthController.dart';
import 'MyBindings/Mybindings.dart';
import 'Repository/RespositoryAuth.dart';
import 'Utils/Colors.dart';
import 'pages/Authentication/Pages/LoginPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      print("FCM Token: $fcmToken");
    } else {
      print("Error: FCM Token is null");
    }
  } catch (e) {
    print("Error getting FCM Token: $e");
  }

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("onMessageOpenedApp: $message");
  });

  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    // Lógica para manipular mensagens em segundo plano
    print("Handling a background message: ${message.data}");
    // Reagir à notificação, se houver
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Mensagem recebida: $message");

    // Acessar dados específicos da mensagem
    print("Dados da mensagem: ${message.data}");

    // Exemplo de acesso a dados específicos, como título e corpo da notificação
    String? title = message.notification?.title;
    String? body = message.notification?.body;

    if (title != null && body != null) {
      print("Título: $title, Corpo: $body");
    }

    // Lógica adicional conforme necessário
  });

  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  await initializeDateFormatting();

  /// GetStorage().erase();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController =
        Get.put<AuthController>(AuthController(RepositoryAuth()));
    return GetBuilder<AuthController>(builder: (_) {
      return GetMaterialApp(
        key: GlobalKey(),
        initialBinding: MyBinding(),
        locale: Locale('de', 'DE'),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.zoom,
        // translations: TranslationService(),
        //  locale: TranslationService.locale,
        // fallbackLocale: TranslationService.fallbackLocale,
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
        home: UpgradeAlert(
          upgrader: Upgrader(
              dialogStyle: GetPlatform.isAndroid
                  ? UpgradeDialogStyle.material
                  : UpgradeDialogStyle.cupertino),
          child: Obx(
            () {
              return authController.isLoggedIn.value
                  ? BottomNavigationWidget()
                  : LoginPage();
            },
          ),
        ),
      );
    });
  }
}
