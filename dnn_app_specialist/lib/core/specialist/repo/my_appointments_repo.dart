import 'package:dnn_shared/dnn_shared.dart';

abstract class IMyAppointmentsRepository {
  Future<HttpResponse<List<MyAppointmentsClinicResponseModel>>> getAppointments(
      {required String doctorId});
}

class MyAppointmentsRepository implements IMyAppointmentsRepository {
  final HttpManager _httpManager;

  MyAppointmentsRepository(this._httpManager);

  @override
  Future<HttpResponse<List<MyAppointmentsClinicResponseModel>>> getAppointments(
      {required String doctorId}) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/schedule/calendar/dates/$doctorId/1',
      method: HttpMethods.get,
      parser: (data) {
        return (data as List<dynamic>)
            .map((e) => MyAppointmentsClinicResponseModel.fromJson(e))
            .toList();
      },
    );
  }
}
