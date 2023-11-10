import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Client {
  final String name;
  final String email;
  final String status;

  Client({required this.name, required this.email, required this.status});
}

class ClientListController extends GetxController {
  var clients = <Client>[
    Client(name: 'João Silva', email: 'joao@email.com', status: 'Agendado'),
    Client(name: 'Maria Souza', email: 'maria@email.com', status: 'Concluído'),
    Client(name: 'Pedro Oliveira', email: 'pedro@email.com', status: 'Pendente'),
  ].obs;
}

class ClientListPage extends StatelessWidget {
  final controller = Get.put(ClientListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.clients.length,
          itemBuilder: (context, index) {
            var client = controller.clients[index];
            return ClientCard(client: client);
          },
        ),
      ),
    );
  }
}

class ClientCard extends StatelessWidget {
  final Client client;

  ClientCard({required this.client});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(client.name),
        subtitle: Text(client.email),
        trailing: Text(client.status),
        onTap: () {
          // Navegar para a tela de detalhes do cliente ou realizar outra ação desejada.
          Get.to(() => ClientDetailsPage(client: client));
        },
      ),
    );
  }
}

class ClientDetailsPage extends StatelessWidget {
  final Client client;

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
            Text('Nome: ${client.name}'),
            Text('Email: ${client.email}'),
            Text('Status: ${client.status}'),
            // Adicione mais detalhes conforme necessário.
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(home: ClientListPage()));
}
