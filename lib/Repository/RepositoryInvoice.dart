import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:therapy_dashboard/Controller/InvoiceController.dart';
import '../IRepository/IRepositoryInvoice.dart';
import '../Models/InvoiceModel.dart';
import '../Models/UserModel.dart';
import '../Utils/const_storage_keys.dart';

class RepositoryInvoice extends GetConnect implements IRepositoryInvoice {
  @override
  void onInit() async {
    // httpClient.baseUrl = dotenv.env['API_URL'];
    final accessToken = StorageKeys.storagedTokenTEST;
    //final accessToken = StorageKeys.storagedToken;
    httpClient.timeout = Duration(seconds: 30);
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.headers['Accept'] = 'application/json';
      defaultContentType = "application/json; charset=utf-8";

      return request;
    });
    super.onInit();
  }

  @override
  Future<InvoiceModel> create(InvoiceModel invoiceModel, XFile file) async {
    try {
      MultipartFile multipartFile =
          MultipartFile(File(file.path), filename: file.name);

      FormData formData = FormData({
        'file': multipartFile,
        'user_obj': "655f4e284683f00236333a66",//Admin ID
        'appointment_obj': InvoiceController.to.appointmentModel,
        'over_duo': invoiceModel.overDuo,
      });
      final response = await httpClient.post(
          'https://therapy-bv4t.onrender.com/api/v1/invoice/create-invoice',
          body: formData);

      if (response.status.isOk) {
        final Map<String, dynamic> responseData = await response.body;

        final newInvoice = InvoiceModel.fromJson(responseData);

        print("responseData::::: $responseData");

        print("Appointment::::: ${newInvoice.id}");

        return newInvoice;
      } else {
        return throw Exception(response.body);
      }
    } catch (e) {
      return throw Exception(e.toString());
    }
  }

  @override
  Future<List<InvoiceModel>> getInvoiceByUserId(String id) async {
    final response = await httpClient.get(
        'https://therapy-bv4t.onrender.com/api/v1/invoice/fetch-invoices/$id');
    if (response.status.isOk) {
      var jsonResponse = await response.body;
      List<dynamic> postList = jsonResponse;
      return postList
          .map<InvoiceModel>((item) => InvoiceModel.fromJson(item))
          .toList();
    }

    if (response.status.hasError) {
      return [];
    }
    if (response.status.isNotFound) {
      return [];
    }
    if (response.status.connectionError) {
      return [];
    }
    print("Body fetch by user id Response:::::::::::::${response.bodyString}");

    throw Exception(response.bodyString);
    // } catch (e) {
    //   throw Exception(e.toString());
    // }
  }

  @override
  // ignore: override_on_non_overriding_member
  Future<void> deleteUser(String id) async {}

  @override
  // ignore: override_on_non_overriding_member
  Future<UserModel> editUser(UserModel userModel) async {
    return UserModel();
  }

  @override
  Future<void> deleteInvoice(String id) {
    // TODO: implement deleteInvoice
    throw UnimplementedError();
  }

  @override
  Future<void> updateInvoice(String id) {
    // TODO: implement updateInvoice
    throw UnimplementedError();
  }
}
