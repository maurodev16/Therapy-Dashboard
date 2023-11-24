import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:therapy_dashboard/Controller/InvoiceController.dart';
import 'package:therapy_dashboard/GlobalWidgets/loadingWidget.dart';

class PdfViewerWidget extends StatelessWidget {
  final XFile pdfFile;
  ///final String userId;

  PdfViewerWidget({required this.pdfFile,});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            AppBar(
              title: Text('PDF Viewer'),
              actions: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            Expanded(
              child: 
            InvoiceController.to.doc == null?
                   Center(child: loadingWidget()):
               
                   PDFViewer(
                      document: InvoiceController.to.doc),
               
            
            ),
          ],
        ),
      ),
    );
  }
}
