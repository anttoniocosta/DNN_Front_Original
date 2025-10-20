import 'package:dnn_shared/dnn_shared.dart';

abstract class ISpecialistRepository {
  Future<HttpResponse<String>> startDuty();
  Future<HttpResponse<String>> finishDuty();
  Future<HttpResponse<bool>> isAlreadyOnDuty();

  Future<HttpResponse<String>> closeTriagem(
      ScheduledTriagemEndRequestModel model);
  Future<HttpResponse<String>> startTriagem(String screeningId);

  Future<HttpResponse<String>> closeScheduled(ScheduledEndRequestModel model);
  Future<HttpResponse<String>> startScheduled(String scheduleServicesId);

  Future<HttpResponse<List<QueueResponseModel>>> getQueueTriagem();
  Future<HttpResponse<List<QueueResponseModel>>> getQueues(bool isReady);
}

class SpecialistRepository implements ISpecialistRepository {
  final HttpManager _httpManager;

  SpecialistRepository(this._httpManager);

  @override
  Future<HttpResponse<String>> startDuty() async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/duty/start',
      method: HttpMethods.post,
      parser: (data) {
        return data['message'];
      },
    );
  }

  @override
  Future<HttpResponse<String>> finishDuty() async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/duty/finish',
      method: HttpMethods.put,
      parser: (data) {
        return data['message'];
      },
    );
  }

  @override
  Future<HttpResponse<String>> closeTriagem(
      ScheduledTriagemEndRequestModel model) async {
    return await _httpManager.request(
      path: '/api/v2/ServiceQueue/screening/clinic/end',
      method: HttpMethods.post,
      body: model.toJson(),
      parser: (data) {
        return data['message'];
      },
    );
  }

  @override
  Future<HttpResponse<bool>> isAlreadyOnDuty() async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/duty/isready',
      method: HttpMethods.get,
      parser: (data) {
        return data;
      },
    );
  }

  @override
  Future<HttpResponse<List<QueueResponseModel>>> getQueueTriagem() async {
    return await _httpManager.request(
      path: '/api/v2/ServiceQueue/screening/clinic',
      method: HttpMethods.get,
      parser: (data) {
        return (data as List<dynamic>)
            .map((e) => QueueResponseModel.fromJson(e))
            .toList();
      },
    );
  }

  @override
  Future<HttpResponse<String>> startTriagem(String screeningId) async {
    return await _httpManager.request(
      path: '/api/v2/ServiceQueue/screening/clinic/start/$screeningId',
      method: HttpMethods.post,
      parser: (data) {
        return data['message'];
      },
    );
  }

  @override
  Future<HttpResponse<List<QueueResponseModel>>> getQueues(bool isReady) async {
    return await _httpManager.request(
      path: '/api/v2/ScheduleServices/Queue/doctor/$isReady',
      method: HttpMethods.get,
      parser: (data) {
        return (data as List<dynamic>)
            .map((e) => QueueResponseModel.fromJson(e))
            .toList();
      },
    );
  }

  @override
  Future<HttpResponse<String>> closeScheduled(
      ScheduledEndRequestModel model) async {
    return await _httpManager.request(
      path: '/api/v2/ScheduleServices/Queue/end',
      method: HttpMethods.post,
      body: model.toJson(),
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<String>> startScheduled(String scheduleServicesId) async {
    return await _httpManager.request(
      path: '/api/v2/ScheduleServices/Queue/start',
      method: HttpMethods.post,
      body: StartScheduleServices(scheduleServicesId: scheduleServicesId)
          .toJson(),
      parser: (data) => data['message'],
    );
  }
}

class StartScheduleServices {
  String? scheduleServicesId;

  StartScheduleServices({this.scheduleServicesId});

  StartScheduleServices.fromJson(Map<String, dynamic> json) {
    scheduleServicesId = json['scheduleServicesId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduleServicesId'] = scheduleServicesId;
    return data;
  }
}
