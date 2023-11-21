import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:therapy_dashboard/GlobalWidgets/customAppBar.dart';
import 'package:therapy_dashboard/GlobalWidgets/loadingWidget.dart';
import 'package:therapy_dashboard/Utils/Colors.dart';
import 'package:therapy_dashboard/Pages/BottonNavPages/InvoicePage.dart';

import '../../Controller/AppointmentController.dart';
import '../../Controller/InvoiceController.dart';

class HomePage extends StatelessWidget {
  final AppointmentController appointmentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: appointmentsScreen(),
    );
  }
}

Widget appointmentsScreen() {
  final AppointmentController appointmentController = Get.find();

  return DefaultTabController(
    length: 3, // Define o número de abas
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Zeitpläne',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          ActionsDotWidget(),

          ///NOTIFICATION ICON
          IconButton(
            onPressed: () async {
              await appointmentController.getSeparateAppoints();
            },
            icon: Icon(
              Icons.refresh_rounded,
            ),
          ),
        ],
        bottom: TabBar(
          tabs: [
            Tab(text: 'Nächste Termin'),
            Tab(text: 'Geschlossen'),
            Tab(text: 'Abgesagt'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // ABA OPEN

          Container(
            height: Get.height,
            child: Obx(() => appointmentController.isLoading.value
                ? loadingWidget()
                  : appointmentController.status.isEmpty
                      ? Center(
                          child: Icon(Icons.alarm_off_rounded, size: 40,),
                        )
                      : appointmentController.status.isError
                          ? Center(child: Icon(Icons.error_outline))
                          : appointmentController.status.isSuccess
                              ? ListView.builder(
                                itemCount:
                                    appointmentController.openAppoint.length,
                                itemBuilder: (context, index) {
                                  var appointment =
                                      appointmentController.openAppoint[index];
                                  return therapyInfoCard(
                                         appointment.userModel!.firstname!,
                                    appointment.userModel!.lastname!,
                                    appointment.date!,
                                    appointment.time!,
                                    appointment.userModel!.clientNumber!,
                                    appointment.status!,
                                  );
                                },
                              )
                            : SizedBox()),
          ),

          ///ABA DONE
         Obx(
              () =>  Container(
            height: Get.height,
            child: appointmentController.isLoading.value
                  ? loadingWidget()
                  : appointmentController.status.isEmpty
                      ? Center(
                          child: Icon(Icons.alarm_off_rounded),
                        )
                      : appointmentController.status.isError
                          ? Center(child: Icon(Icons.error_outline))
                          : appointmentController.status.isSuccess
                              ? ListView.builder(
                                  itemCount:
                                      appointmentController.doneAppoint.length,
                                  itemBuilder: (context, index) {
                                    var appointment = appointmentController
                                        .doneAppoint[index];
                                    return therapyInfoCard(
                                           appointment.userModel!.firstname!,
                                    appointment.userModel!.lastname!,
                                      appointment.date!,
                                      appointment.time!,
                                      appointment.userModel!.clientNumber!,
                                      appointment.status!,
                                    );
                                  },
                                )
                              : SizedBox(),
            ),
          ),

          //ABA CANCELED
          ///ABA DONE
          Container(
            height: Get.height,
            child: Obx(() => appointmentController.isLoading.value
               ? loadingWidget()
                  : appointmentController.status.isEmpty
                      ? Center(
                          child: Icon(Icons.alarm_off_rounded),
                        )
                      : appointmentController.status.isError
                          ? Center(child: Icon(Icons.error_outline))
                          : appointmentController.status.isSuccess
                              ?ListView.builder(
                                itemCount: appointmentController
                                    .canceledAppoint.length,
                                itemBuilder: (context, index) {
                                  var appointment = appointmentController
                                      .canceledAppoint[index];
                                  return therapyInfoCard(
                                    appointment.userModel!.firstname!,
                                    appointment.userModel!.lastname!,
                                    appointment.date!,
                                    appointment.time!,
                                    appointment.userModel!.clientNumber!,
                                    appointment.status!,
                                  );
                                },
                              )
                            : SizedBox()),
          ),
        ],
      ),
    ),
  );
}

Widget therapyInfoCard(
   String firstname,
   String lastname,
  DateTime date,
  DateTime time,
  int clienteNumber,
  String status,
) {
  return Card(
    elevation: 3,
    margin: EdgeInsets.all(10),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Frist name: $firstname',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
            Text(
            'Frist name: $lastname',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
           Text(
            'Termin datum: ${date.day}.${date.month}.${date.year}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Time: ${DateFormat.Hm().format(time)}',
            style: TextStyle(fontSize: 22),
          ),
          Text(
            'Nummer: $clienteNumber',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            'KN: $clienteNumber',
            style: TextStyle(fontSize: 10),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Icon(
                  Icons.pending,
                  color: verde,
                ),
                SizedBox(width: 5),
                // Text('$firstname'),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    ),
  );
}

class ActionsDotWidget extends StatelessWidget {
  const ActionsDotWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Hero(
          tag: "tagVermelho",
          child: TextButton.icon(
            onPressed: () {
              Get.to(() => InvoicePage());
            },
            icon: Icon(
              Icons.pending,
              size: 15,
              color: vermelho,
            ),
            label: Text(
              "99+",
              style: TextStyle(fontSize: 10, color: vermelho),
            ),
          ),
        ),
        Hero(
          tag: "tagVerde",
          child: TextButton.icon(
            onPressed: () {
              Get.to(() => InvoicePage());
            },
            icon: Icon(
              Icons.pending,
              size: 15,
              color: verde,
            ),
            label: Text(
              "15",
              style: TextStyle(fontSize: 10, color: verde),
            ),
          ),
        ),
        Hero(
          tag: "tagAzul",
          child: TextButton.icon(
            onPressed: () {
              Get.to(() => InvoicePage());
            },
            icon: Icon(
              Icons.pending,
              size: 15,
              color: azul,
            ),
            label: Text(
              "0",
              style: TextStyle(fontSize: 10, color: azul),
            ),
          ),
        ),
        Hero(
          tag: "tagPreto",
          child: TextButton.icon(
            onPressed: () {
              Get.to(() => InvoicePage());
            },
            icon: Icon(
              Icons.pending,
              size: 15,
              color: preto,
            ),
            label: Text(
              "${InvoiceController.to.overdueInvoice.length.toString()}",
              style: TextStyle(fontSize: 10, color: preto),
            ),
          ),
        ),
      ],
    );
  }
}
