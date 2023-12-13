import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy_dashboard/Utils/Colors.dart';

import '../../Controller/InvoiceController.dart';
import '../../Models/InvoiceModel.dart';

class InvoicePage extends StatelessWidget {
  final InvoiceController invoiceController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rechnungsübersicht',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints.expand(height: Get.height * 0.1),
              child: TabBar(
                tabs: [
                  Obx(() => Tab(
                      text: '${invoiceController.openInvoices.length} Offene',
                      icon: Hero(
                          tag: "tagVermelho",
                          child: Icon(Icons.pending, color: verde, size: 25)))),
                  Obx(
                    () => Tab(
                      text: '${invoiceController.paidInvoices.length} Bezahlt',
                      icon: Hero(
                          tag: "tgVerde",
                          child: Icon(Icons.pending, color: amarelo, size: 25)),
                    ),
                  ),
                  Obx(() => Tab(
                      text:
                          '${invoiceController.stornedInvoices.length} Storniert',
                      icon: Hero(
                          tag: "tagAzul",
                          child: Icon(Icons.pending, color: azul, size: 25)))),
                  Obx(() => Tab(
                      text:
                          '${invoiceController.overdueInvoices.length} überfällig',
                      icon: Hero(
                          tag: "tagPreto",
                          child: Icon(Icons.pending, color: preto, size: 25)))),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Content of "Open" tab
                  OpenInvoiceListView(status: 'Open'),

                  // Content of "completed" tab
                  PaidInvoiceListView(status: 'Paid'),

                  // Content of "Pending" tab
                  RefundedInvoiceListView(status: 'Refunded'),

                  //Content of "Overduo" tab
                  OverDuoInvoiceListView(status: 'OverDuo'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
class OpenInvoiceListView extends StatelessWidget {
  final InvoiceController invoiceController = Get.find();
  final String status;

  OpenInvoiceListView({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: invoiceController.openInvoices.length,
      itemBuilder: (context, index) {
        InvoiceModel invoice = invoiceController.openInvoices[index];
        return InvoiceCard(invoice: invoice);
      },
    );
  }
}

///
class PaidInvoiceListView extends StatelessWidget {
  final InvoiceController invoiceController = Get.find();
  final String status;

  PaidInvoiceListView({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: invoiceController.paidInvoices.length,
      itemBuilder: (context, index) {
        InvoiceModel invoice = invoiceController.paidInvoices[index];
        return InvoiceCard(invoice: invoice);
      },
    );
  }
}

//////
class RefundedInvoiceListView extends StatelessWidget {
  final InvoiceController invoiceController = Get.find();
  final String status;

  RefundedInvoiceListView({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: invoiceController.stornedInvoices.length,
      itemBuilder: (context, index) {
        InvoiceModel invoice = invoiceController.stornedInvoices[index];
        return InvoiceCard(invoice: invoice);
      },
    );
  }
}

//////
class OverDuoInvoiceListView extends StatelessWidget {
  final InvoiceController invoiceController = Get.find();
  final String status;

  OverDuoInvoiceListView({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: invoiceController.overdueInvoices.length,
      itemBuilder: (context, index) {
        InvoiceModel invoice = invoiceController.overdueInvoices[index];
        return InvoiceCard(invoice: invoice);
      },
    );
  }
}

///
class InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;

  InvoiceCard({required this.invoice});

  @override
  Widget build(BuildContext context) {
    late Icon icon;

    switch (invoice.invoiceStatus) {
      case 'open':
        icon = Icon(Icons.pending, color: verde);
        break;
      case 'paid':
        icon = Icon(Icons.pending, color: amarelo);
        break;
      case 'refunded':
        icon = Icon(Icons.pending, color: azul);
        break;
      case 'overduo':
        icon = Icon(Icons.pending, color: preto);
        break;
    }

    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        icon,
                        SizedBox(width: 5),
                      ],
                    ),
                  )
                ],
              ),
              Text(
                "${extractFileName(invoice.invoiceUrl!)}",
                style: GoogleFonts.lato(fontSize: 12),
              ),
              Text(
                  'Überfälligkeitsdatum: ${invoice.overDuo!.day}.${invoice.overDuo!.month}.${invoice.overDuo!.year}'),
            ],
          ),
        ),
      ),
    );
  }
}

String extractFileName(String url) {
  int lastIndex = url.lastIndexOf("-");
  if (lastIndex != -1) {
    return url.substring(lastIndex + 1);
  } else {
    return url;
  }
}
