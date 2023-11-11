import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapy_dashboard/GlobalWidgets/loadingWidget.dart';
import 'package:therapy_dashboard/Models/UserModel.dart';

import '../../Controller/ClientListPageController.dart';
class ClientListPage extends GetView<ClientListController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
        () => Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
      ),
      body: controller.isLoading.value ? LoadingWidget():
      controller.status.isEmpty?Center(child: Text("Empty"),):
      controller.status.isError? Center(child: Text("Error"),):
      controller.status.isSuccess?
        ListView.builder(
          itemCount: controller.listOfAllUsers.length,
          itemBuilder: (context, index) {
            var client = controller.listOfAllUsers[index];
            return ClientCard(client: client);
          },
        ):
       SizedBox.shrink(),
    ),);
  }
}

class ClientCard extends StatelessWidget {
  final UserModel client;

  ClientCard({required this.client});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(client.firstname!),
        subtitle: Text(client.lastname!),
        trailing: Text(client.email!),
        dense: true,
        onTap: () {
          // Navegar para a tela de detalhes do cliente ou realizar outra ação desejada.
          Get.to(() => ClientDetailsPage(client: client));
        },
      ),
    );
  }
}

class ClientDetailsPage extends StatelessWidget {
  final UserModel client;

  ClientDetailsPage({required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Cliente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First name: ${client.firstname}'),
            Text('Last name: ${client.lastname}'),
            Text('Email: ${client.email}'),
            Text('ID: ${client.userId}'),
            Text('Created: ${client.createdAt}'),
            Text('Updated: ${client.updatedAt}'),
          ],
        ),
      ),
    );
  }
}

