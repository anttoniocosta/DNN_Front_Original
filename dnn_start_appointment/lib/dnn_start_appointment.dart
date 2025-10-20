library dnn_start_appointment;

import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:get/get.dart';

export '_rapidoc/_old/export.dart';
export './modules/schedule_appointment/export.dart';
export './modules/my_appointments/export.dart';
export './modules/screening/export.dart';
export './core/export.dart';

final startAppointmentController = Get.find<StartAppointmentController>();
