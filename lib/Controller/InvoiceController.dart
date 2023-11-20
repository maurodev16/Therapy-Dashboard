import 'package:get/get.dart';
import 'package:therapy_dashboard/Models/InvoiceModel.dart';

class InvoiceController extends GetxController {
  static InvoiceController get to => Get.find();
  late final List<InvoiceModel> pendingInvoice;
  @override
  void onInit() async {
   
    await separateInvoice();
    super.onInit();
  }

  List<InvoiceModel> overdueInvoice = <InvoiceModel>[].obs;
  List<InvoiceModel> refundRequests = <InvoiceModel>[].obs;


  bool isPaymentDue(InvoiceModel bill) {
    // Verifica se a data de vencimento é anterior à data atual
    return bill.overDuo!.isBefore(DateTime.now());
  }

  // Método para separar os pagamentos vencidos e os pedidos de estorno
  Future<void> separateInvoice() async {
    for (InvoiceModel bill in pendingInvoice) {
      bool isDue = isPaymentDue(bill);
      if (isDue) {
        // Adicionar à lista de pagamentos vencidos
        overdueInvoice.add(bill);
      } else {
        // Adicionar à lista de pedidos de estorno (se necessário)
        if (bill.invoiceStatus == 'refund') {
          refundRequests.add(bill);
        }
      }
      update();
    }
  }
}
