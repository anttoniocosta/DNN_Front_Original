import 'dart:async';
import 'dart:developer';

import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/dnn_payment.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';

class PixController extends IPaymentController {
  final IPaymentV2Repository _repository;

  PixController(this._repository);

  RxBool getPaymentDetails = false.obs;

  @override
  Future<void> payCart() async {
    final cicle = await storage.getPaymentCicle();
    log(cicle!.toString());
    if (cicle == PaymentEnum.PURCHASE) await payment();
    if (cicle == PaymentEnum.RENEWAL) await renewal();
    if (cicle == PaymentEnum.SCHEDULE) await schedule();
  }

  @override
  Future<void> renewal() async {
    setLoading(isLoading, true);
    try {
      final result =
          await _repository.renewal(renewal: await requestModelForStadard());

      if (result.data != null) {
        paymentResponse = result.data;
        paymentDetailsController.getPaymentContract(
          currentPage: Routes.paymentResumePix,
          paymentResponse: paymentResponse,
        );
        update();
      } else {
        paymentError = result.error;
        Get.offNamed(Routes.paymentError, arguments: paymentError!.message);
        update();
      }
    } catch (e) {
      Get.offNamed(Routes.paymentError, arguments: e.toString());
    }
    setLoading(isLoading, false);
  }

  @override
  Future<void> payment() async {
    setLoading(isLoading, true);
    try {
      final result =
          await _repository.payment(payment: await requestModelForStadard());

      if (result.data != null) {
        paymentResponse = result.data;
        paymentDetailsController.getPaymentContract(
          currentPage: Routes.paymentResumePix,
          paymentResponse: paymentResponse,
        );
        update();
      } else {
        paymentError = result.error;
        Get.offNamed(Routes.paymentError, arguments: paymentError!.message);
        update();
      }
    } catch (e) {
      Get.offNamed(Routes.paymentError, arguments: e.toString());
    }
    setLoading(isLoading, false);
  }

  @override
  Future<void> schedule() async {
    setLoading(isLoading, true);
    try {
      final result =
          await _repository.schedule(schedule: await requestModelForSchedule());

      if (result.data != null) {
        paymentResponse = PaymentResponseModel.fromScheduleModel(result.data!);
        paymentDetailsController.getPaymentSchedule(
          currentPage: Routes.paymentResumePix,
          paymentResponse: paymentResponse,
        );
        update();
        Get.find<MyAppointmentsController>()
            .setScheduleConsultationId(result.data!.scheduleConsultationId!);
      }
      if (result.error != null) {
        log(result.error!.message!);
        paymentError = result.error;
        Get.offNamed(Routes.paymentError, arguments: paymentError!.message);
        update();
      }
    } catch (e) {
      Get.offNamed(Routes.paymentError, arguments: e.toString());
    }
    setLoading(isLoading, false);
  }
}
