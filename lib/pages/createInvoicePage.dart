import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy_dashboard/Controller/InvoiceController.dart';
import 'package:therapy_dashboard/Utils/Colors.dart';

class CreateInvoicePage extends StatelessWidget {
  final appointment = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rechnung erstellen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Rechnungsdetails",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text(appointment.id),
            SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              enabled: false,
              initialValue: appointment.userModel.clientNumber.toString(),
              decoration: InputDecoration(
                labelText: 'ID',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.assignment_ind_outlined),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              enabled: false,
              initialValue:
                  "${appointment.userModel.firstname} ${appointment.userModel.lastname}",
              decoration: InputDecoration(
                labelText: "Kundenname",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              // Você pode usar um controlador para lidar com os dados de entrada
              // controller: seuControlador,
            ),
            SizedBox(height: 16),
            Obx(
              () => InkWell(
                onTap: InvoiceController.to.isLoading.value == false
                    ? () {
                        InvoiceController.to.selectDate(context);
                      }
                    : null,
                child: TextFormField(
                  readOnly: true,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: '${InvoiceController.to.rxOverduo.value.day}.${InvoiceController.to.rxOverduo.value.month}.${InvoiceController.to.rxOverduo.value.year}'
                            .split(' ')[0],
                    border: OutlineInputBorder(),
                    hintText:
                        '${InvoiceController.to.rxOverduo.value}'.split(' ')[0],
                    prefixIcon: Icon(Icons.calendar_month),
                  ),
             
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Obx(
                  () => ElevatedButton(
                    onPressed: InvoiceController.to.isLoading.value == false
                        ? () {
                          
                            InvoiceController.to.pickFileFromGallery();
                          }
                        : null,
                    child: Text(
                      'Datei hochladen',
                      style:
                          GoogleFonts.lato(fontSize: 15, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          vermelho, // Defina a cor de fundo como vermelho
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 5),
            Obx(
              () => Text(
                '${InvoiceController.to.pickedFilename.value}',
                style: GoogleFonts.lato(fontSize: 10),
              ),
            ),
            SizedBox(height: 25),
            Obx(
              () => ElevatedButton(
                onPressed: InvoiceController.to.getPickedFile != null &&
                        InvoiceController.to.isLoading.value == false
                    ? () {
                   
                        InvoiceController.to.createInvoice();
                      }
                    : null,
                child: Text(
                  'Rechnung speichern',
                  style: GoogleFonts.lato(fontSize: 15, color: preto),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
