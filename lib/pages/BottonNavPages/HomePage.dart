import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapy_dashboard/GlobalWidgets/loadingWidget.dart';
import 'package:therapy_dashboard/Utils/Colors.dart';
import 'package:therapy_dashboard/Pages/BottonNavPages/BillsPage.dart';

import '../../Controller/AppointmentController.dart';
import '../../Controller/BillsController.dart';

class HomePage extends StatelessWidget {
final AppointmentController appointmentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: appointmentController.getAllAppoint(), // Chame o método para buscar os agendamentos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: LoadingWidget());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return appointmentsScreen();
          }
        },
      ),
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
          Row(
            children: [
              Hero(
                tag: "tagVermelho",
                child: TextButton.icon(
                  onPressed: () {
                    Get.to(() => BillsPage());
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
                    Get.to(() => BillsPage());
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
                    Get.to(() => BillsPage());
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
                    Get.to(() => BillsPage());
                  },
                  icon: Icon(
                    Icons.pending,
                    size: 15,
                    color: preto,
                  ),
                  label: Text(
                    "${BillsController.to.overdueBills.length.toString()}",
                    style: TextStyle(fontSize: 10, color: preto),
                  ),
                ),
              ),
            ],
          ),

          ///NOTIFICATION ICON
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
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
          for (var appointment in appointmentController.allAppoint)
            therapyInfoCard(
              'Zahlungsstatus: Offene',
              appointment.date!,
              appointment.time!,
              appointment.userModel!.clientNumber!,
              appointment.status!
            ),
            for (var appointment in appointmentController.allAppoint)
            therapyInfoCard(
              'Zahlungsstatus: Offene',
              appointment.date!,
              appointment.time!,
              appointment.userModel!.clientNumber!,
              appointment.status!
            ),
            for (var appointment in appointmentController.allAppoint)
            therapyInfoCard(
              'Zahlungsstatus: Offene',
              appointment.date!,
              appointment.time!,
              appointment.userModel!.clientNumber!,
              appointment.status!
            ),
        ],
      ),
     
    ),
  );
}

Widget therapyInfoCard(
  String statusText,
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
            'date: $date',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Kunder Nummer: $clienteNumber',
            style: TextStyle(fontSize: 10),
          ),
           Text(
            'Time: $time',
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
                Text('$statusText'),
              ],
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text("Status"),
            subtitle: Text(status),
          ),
        ],
      ),
    ),
  );
}
