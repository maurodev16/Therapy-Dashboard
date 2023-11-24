import 'dart:convert';
import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:therapy_dashboard/IRepository/IRepositoryInvoice.dart';
import 'package:therapy_dashboard/Models/InvoiceModel.dart';

class InvoiceController extends GetxController
    with StateMixin<List<InvoiceModel>> {
  final IRepositoryInvoice _repositoryInvoice;
  InvoiceController(this._repositoryInvoice);
  static InvoiceController get to => Get.find();
  List<InvoiceModel> allInvoice = <InvoiceModel>[].obs;
  List<InvoiceModel> pendingInvoice = <InvoiceModel>[].obs;
  List<InvoiceModel> overdueInvoice = <InvoiceModel>[].obs;
  List<InvoiceModel> refundRequests = <InvoiceModel>[].obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    await separateInvoice();
   
    super.onInit();
  }

  Rx<XFile?> _pickedFile = Rx<XFile?>(null);
  String? _base64File;

  XFile? get pickedFile {
    return _pickedFile.value;
  }

  set setPickedFile(XFile? pickedFile) {
    this._pickedFile.value = pickedFile;
  }

  String? get base64File => _base64File;
late final  PDFDocument doc;
 Future<void> loadPdf() async {
File file  = File(_pickedFile.value!.path);
doc = await PDFDocument.fromFile(file);

  update();
  }

 Future<void> pickFileFromGallery() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null && result.files.isNotEmpty) {
    final pickedFile = XFile(result.files.first.path!);
    _pickedFile.value = pickedFile;

    final fileBytes = await pickedFile.readAsBytes();
    _base64File = base64Encode(fileBytes);

loadPdf();
  } else {
    update();
    return null;
  }

  update();
}


  late Rx<InvoiceModel> _invoiceModel = InvoiceModel().obs;

  Rx<InvoiceModel> get getInvoiceData => this._invoiceModel;

  set setInvoiceData(Rx<InvoiceModel> invoiceData) => this._invoiceModel = invoiceData;

  Future<InvoiceModel> createInvoice() async {
    isLoading.value = false;
    if (_pickedFile.value != null) {
      final invoiceModel = InvoiceModel().obs;
      InvoiceModel? createdInvoice = await _repositoryInvoice.create(
          invoiceModel.value, _pickedFile.value!);
      print('Novo invoice ID: ${createdInvoice.id}');
      change([], status: RxStatus.success());
      _invoiceModel.update((invoice) {
        invoice!.id = createdInvoice.id;
        invoice.createBy = createdInvoice.createBy;
        invoice.invoiceUrl = createdInvoice.invoiceUrl;
        invoice.overDuo = createdInvoice.overDuo;
        invoice.invoiceStatus = createdInvoice.invoiceStatus;
        invoice.appointmentObj = createdInvoice.appointmentObj;
        invoice.userObj = createdInvoice.userObj;
      });
      return createdInvoice;
    }
    return _invoiceModel.value;
  }

  bool isPaymentDue(InvoiceModel invoice) {
    // Verifica se a data de vencimento é anterior à data atual
    return invoice.overDuo!.isBefore(DateTime.now());
  }

  // Método para separar os pagamentos vencidos e os pedidos de estorno
  Future<void> separateInvoice() async {
    for (InvoiceModel invoice in pendingInvoice) {
      bool isDue = isPaymentDue(invoice);
      if (isDue) {
        // Adicionar à lista de pagamentos vencidos
        overdueInvoice.add(invoice);
      } else {
        // Adicionar à lista de pedidos de estorno (se necessário)
        if (invoice.invoiceStatus == 'refund') {
          refundRequests.add(invoice);
        }
      }
      update();
    }
  }

}
