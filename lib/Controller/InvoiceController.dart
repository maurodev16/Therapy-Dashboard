import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:therapy_dashboard/IRepository/IRepositoryInvoice.dart';
import 'package:therapy_dashboard/Models/InvoiceModel.dart';

import '../Models/AppointmentModel.dart';
import '../Utils/Colors.dart';

class InvoiceController extends GetxController
    with StateMixin<List<InvoiceModel>> {
  final IRepositoryInvoice _repositoryInvoice;
  InvoiceController(this._repositoryInvoice);
  static InvoiceController get to => Get.find();
  List<InvoiceModel> allInvoice = <InvoiceModel>[].obs;
  List<InvoiceModel> pendingInvoice = <InvoiceModel>[].obs;
  List<InvoiceModel> overdueInvoice = <InvoiceModel>[].obs;
  List<InvoiceModel> refundRequests = <InvoiceModel>[].obs;
  RxString pickedFilename = "".obs;
 Rx<DateTime> rxOverduo= DateTime.now().obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    await separateInvoice();

    super.onInit();
  }

  Rx<AppointmentModel> appointmentModel = AppointmentModel().obs;
// Método para receber os dados do agendamento
  void receiveAppointmentData(AppointmentModel appointment) {
    appointmentModel.value = appointment;
    print(
        "Dados do agendamento recebidos: ${appointment.userModel?.firstname}, ${appointment.id},");
    print("${appointmentModel.value.id}");
  }

  Future<InvoiceModel> createInvoice() async {
    isLoading.value = true;
    if (_pickedFile.value != null) {
    
      final invoiceModel = InvoiceModel(
        userObj: appointmentModel.value.userModel,
        appointmentObj: appointmentModel.value,
        overDuo: rxOverduo.value,
      ).obs;
      InvoiceModel? createdInvoice = await _repositoryInvoice.create(
          invoiceModel.value, _pickedFile.value!);
      print('Novo invoice ID: ${createdInvoice.id}');
      change([], status: RxStatus.success());
      Fluttertoast.showToast(
        msg: "Sucesso",
        gravity: ToastGravity.TOP,
        backgroundColor: preto,
        fontSize: 12,
        textColor: vermelho,
      );
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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) {
      return;
    } else {
      rxOverduo.value = pickedDate;
    }

    update();
  }

  Rx<XFile?> _pickedFile = Rx<XFile?>(null);
  String? _base64File;

  XFile? get getPickedFile {
    return _pickedFile.value;
  }

  set setPickedFile(XFile? pickedFile) {
    this._pickedFile.value = pickedFile;
  }

  String? get base64File => _base64File;

  Future<void> pickFileFromGallery() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      final pickedFile = XFile(result.files.first.path!);
      _pickedFile.value = pickedFile;
      pickedFilename.value = pickedFile.name;
      print("${_pickedFile.value}");
      final fileBytes = await pickedFile.readAsBytes();
      _base64File = base64Encode(fileBytes);
    } else {
      update();
      return null;
    }

    update();
  }

  late Rx<InvoiceModel> _invoiceModel = InvoiceModel().obs;

  Rx<InvoiceModel> get getInvoiceData => this._invoiceModel;

  set setInvoiceData(Rx<InvoiceModel> invoiceData) =>
      this._invoiceModel = invoiceData;

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
