import 'package:dnn_core/core/utils/typedef/typedef.dart';
import 'package:dnn_shared/dnn_shared.dart';

abstract class IMyAppointmentsRepository {
  Future<HttpResponse<List<MyAppointmentsResponseModel>>> getMyAppointments();
  Future<HttpResponse<String>> cancelAppointment(DataMap map);

  //*Triagem
  Future<HttpResponse<ScreeningQueueModel>> getTriagemQueuePosition(
      String screeningId);

  Future<HttpResponse<StartScreeningResponseModel>> startTriagemQueue(
      StartScreeningRequestModel model);
  Future<HttpResponse<String>> cancelTriagemQueue(String screeningId);
  Future<HttpResponse<String>> cancelStardardQueue(String scheduleServicesId);
  Future<HttpResponse<String>> startStandardQueue(
      StartStandardRequestModel model);

  //*Atendimento normal
  Future<HttpResponse<ScreeningQueueModel>> getStandardQueuePosition();
  Future<HttpResponse<ScheduledFinalStatusModel>> getScheduleTriagemStatus(
      String screeningId);
  Future<HttpResponse<ScheduledFinalStatusModel>> getScheduleStatus(
      String scheduleServiceId);
}

class MyAppointmentsRepository implements IMyAppointmentsRepository {
  final HttpManager _httpManager;

  MyAppointmentsRepository(this._httpManager);

  @override
  Future<HttpResponse<List<MyAppointmentsResponseModel>>>
      getMyAppointments() async {
    return await _httpManager.request(
      path: '/api/v2/Schedule/calendar',
      method: HttpMethods.get,
      parser: (data) {
        return (data as List<dynamic>)
            .map((e) => MyAppointmentsResponseModel.fromJson(e))
            .toList();
      },
    );
  }

  @override
  Future<HttpResponse<String>> cancelAppointment(DataMap map) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/schedule/cancel',
      method: HttpMethods.delete,
      body: map,
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<ScreeningQueueModel>> getTriagemQueuePosition(
      String screeningId) async {
    return await _httpManager.request(
      path: '/api/v2/ServiceQueue/Screening/$screeningId',
      method: HttpMethods.get,
      parser: (data) => ScreeningQueueModel.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<StartScreeningResponseModel>> startTriagemQueue(
      StartScreeningRequestModel model) async {
    return await _httpManager.request(
      path: '/api/v2/ServiceQueue/screening/start',
      method: HttpMethods.post,
      body: model.toJson(),
      parser: (data) => StartScreeningResponseModel.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<String>> cancelTriagemQueue(String screeningId) async {
    return await _httpManager.request(
      path: '/api/v2/ServiceQueue/screening/cancel/$screeningId',
      method: HttpMethods.delete,
      parser: (data) => 'Você saiu da fila de triagem com sucesso!',
    );
  }

  @override
  Future<HttpResponse<String>> startStandardQueue(
      StartStandardRequestModel model) async {
    return await _httpManager.request(
      path: '/api/v2/ScheduleServices/Queue/start/patient',
      method: HttpMethods.post,
      body: model.toJson(),
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<String>> cancelStardardQueue(
      String scheduleServicesId) async {
    return await _httpManager.request(
      path: '/api/v2/ScheduleServices/Queue/cancel/$scheduleServicesId',
      method: HttpMethods.delete,
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<ScreeningQueueModel>> getStandardQueuePosition() async {
    return await _httpManager.request(
      path: '/api/v2/ScheduleServices/Queue/patient',
      method: HttpMethods.get,
      parser: (data) => ScreeningQueueModel.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<ScheduledFinalStatusModel>> getScheduleStatus(
      String scheduleServiceId) async {
    return await _httpManager.request(
      path: '/api/v2/ScheduleServices/Queue/state/$scheduleServiceId',
      method: HttpMethods.get,
      parser: (data) => ScheduledFinalStatusModel.fromJson(data),
    );
  }

  @override
  Future<HttpResponse<ScheduledFinalStatusModel>> getScheduleTriagemStatus(
      String screeningId) async {
    return await _httpManager.request(
      path: '/api/v2/ServiceQueue/screening/state/$screeningId',
      method: HttpMethods.get,
      parser: (data) => ScheduledFinalStatusModel.fromJson(data),
    );
  }
}
