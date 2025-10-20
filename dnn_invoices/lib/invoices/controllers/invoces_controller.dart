import 'package:dnn_core/core/common/loading.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_invoices/dnn_invoices.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class InvoicesController extends GetxController {
  final IInvoicesRepository _repository;

  InvoicesController(this._repository);

  RxBool getInvoicesLoading = false.obs;
  RxBool getInvoicesServicesLoading = false.obs;
  RxBool getInvoicesOrdersLoading = false.obs;
  RxBool getPaymentDetails = false.obs;
  setLoading(RxBool loading, bool status) {
    loading.value = status;
    update();
  }

  @override
  onInit() async {
    getInvoices();
    super.onInit();
  }

  List<InvoiceResponseModel> contractList = [];
  List<InvoiceResponseModel> activeContractList = [];
  List<InvoicePaymentDetailsModel> invoicesByOrder = [];
  List<InvoicePaymentDetailsModel> invoicesForPay = [];
  List<InvoiceServiceModel> invoicesServices = [];
  InvoicePaymentDetailsModel? paymentDetails;
  List<dynamic> checkedList = [];
  String? orderId;

  double invoiceTotalPrice = 0.0;

  setOrderId(String id) {
    storage.saveOrderId(id);
    orderId = id;
    update();
  }

  addInvoiceToList(bool val, InvoicePaymentDetailsModel invoice) {
    if (!val) {
      invoicesForPay.removeWhere((e) => e == invoice);
      update();
    } else {
      invoicesForPay.addIf(!invoicesForPay.contains(invoice), invoice);
      update();
    }
    debugPrint(invoicesForPay.toString());
  }

  addInvoicesToList(List<InvoicePaymentDetailsModel> invoices) {
    invoicesForPay.clear();
    final orderIfIsNotPaied = invoices.where((x) => x.isPaid == false);
    invoicesForPay.addAll(orderIfIsNotPaied);
    debugPrint(invoicesForPay.toString());
    update();
  }

  Future<void> saveInvoicesIdsList() async {
    await storage.saveGetPaymentIds(
      invoicesForPay.map((e) => e.paymentId!).toList(),
    );
    update();
  }

  List<double> getInvoicesForPayTotal() {
    final list = invoicesForPay.map((e) => e.total!).toList();
    update();
    return list;
  }

  Future<void> totalPrice() async {
    if (invoicesForPay.length == 1) {
      await storage.setTotalPrice(invoicesForPay[0].total!);
      invoiceTotalPrice = invoicesForPay[0].total!;
    }
    await storage
        .setTotalPrice(getInvoicesForPayTotal().reduce((a, b) => a + b));
    invoiceTotalPrice = getInvoicesForPayTotal().reduce((a, b) => a + b);
    update();
  }

  void setCheckedList() {
    checkedList = List.generate(
      invoicesByOrder.length,
      (index) => {'checked': false, 'order': invoicesByOrder[index]},
    );
    update();
  }

  Future<void> getInvoices({bool? force}) async {
    setLoading(getInvoicesLoading, true);
    try {
      final result = await _repository.getInvoices(force: force);

      if (result.data != null) {
        contractList = result.data!;
        activeContractList = result.data!
            .where(
              (contract) =>
                  contract.cancelationAt == null && contract.blockedAt == null,
            )
            .toList();
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(getInvoicesLoading, false);
  }

  Future<void> getInvoicesServices() async {
    setLoading(getInvoicesServicesLoading, true);
    try {
      final result = await _repository.getInvoicesServices();

      if (result.data != null) {
        invoicesServices = result.data!;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(getInvoicesServicesLoading, false);
  }

  Future<void> getInvoicesPaymentDetail(String paymentId) async {
    setLoading(getPaymentDetails, true);
    try {
      final result =
          await _repository.getInvoicePaymentDetail(paymentId: paymentId);

      if (result.data != null) {
        paymentDetails = result.data!;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(getPaymentDetails, false);
  }

  Future<void> getInvoicesOrder(String orderId) async {
    invoicesByOrder.clear();
    update();
    Loading.show(title: 'Buscando dados...');
    try {
      final result = await _repository.getInvoiceOrder(orderId: orderId);

      if (result.data != null) {
        invoicesByOrder = result.data!;
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    Loading.hide();
  }

  Future<void> cancelInvoice(String paymentId) async {
    try {
      final result = await _repository.cancelInvoice(paymentId: paymentId);

      if (result.data != null) {
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changeCheckbox(int index, bool val) async {
    checkedList[index]['checked'] = val;
    if (val) {
      for (int i = 0; i < index; i++) {
        if (checkedList[i]['order'].isPaid == false) {
          checkedList[i]['checked'] = val;
        }
      }
    }
    for (int i = index + 1; i < checkedList.length; i++) {
      if (i >= index) {
        if (checkedList[i]['order'].isPaid == false) {
          checkedList[i]['checked'] = false;
        }
      }
    }
    update();
  }

  Future<dynamic> goToInvoicesForPayDetails() async {
    if (checkedList.firstWhereOrNull((x) => x['checked'] == true) == null) {
      CustomDialogs.confirmDialog(
        title: 'Você não selecionou nenhuma fatura',
        backAcion: () => Get.back(),
        confirmAcion: () => Get.back(),
        context: Get.context!,
        backVisible: false,
      );
      return;
    }
    List<InvoicePaymentDetailsModel> orders = checkedList
        .where((x) => x['checked'] == true)
        .map((e) => e['order'] as InvoicePaymentDetailsModel)
        .toList();
    addInvoicesToList(orders);
    totalPrice();
    Get.toNamed(Routes.myContractsInvoicesResume);
  }
}
