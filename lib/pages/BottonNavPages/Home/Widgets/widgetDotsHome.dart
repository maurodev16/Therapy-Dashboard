import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapy_dashboard/Utils/Colors.dart';

import '../../../../Controller/InvoiceController.dart';

class ActionsDotWidget extends StatelessWidget {
  ActionsDotWidget({Key? key}) : super(key: key);
  final InvoiceController invoiceController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                children: [
                  Badge.count(
                    count: invoiceController.openInvoices.length,
                    child: Icon(
                      Icons.pending,
                      size: 25,
                      color: verde,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Badge.count(
                    count: invoiceController.doneInvoices.length,
                    child: Icon(
                      Icons.pending,
                      size: 25,
                      color: amarelo,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Badge.count(
                    count: invoiceController.stornedInvoices.length,
                    child: Icon(
                      Icons.pending,
                      size: 25,
                      color: azul,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Badge.count(
                    count: invoiceController.overdueInvoices.length,
                    child: Icon(
                      Icons.pending,
                      size: 25,
                      color: preto,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
