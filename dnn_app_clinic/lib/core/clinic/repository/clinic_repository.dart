import 'package:dnn_core/core/utils/typedef/typedef.dart';
import 'package:dnn_shared/dnn_shared.dart';

abstract class IClinicRepository {
  Future<HttpResponse<String>> createClinic({
    required CreateClinicParams params,
  });
  Future<HttpResponse<String>> createSpecialist({
    required CreateSpecialistParams params,
  });
  Future<HttpResponse<String>> updateSpecialist({
    required CreateSpecialistParams params,
  });
  Future<HttpResponse<List<SpecialistResponseModel>>> getMySpecialists();
  Future<HttpResponse<List<TypeScheduleResponse>>> getTypeSchedule();
  Future<HttpResponse<List<SpecialtyResponseModel>>> getSpecialties();
  Future<HttpResponse<ScheduledDatesResponseModel>>
      getSchedulesFromSpecialistId({
    required String id,
  });
  Future<HttpResponse<String>> postPublishAgenda(
    PublishAgendaRequestModel model,
  );

  Future<HttpResponse<bool>> checkHour(
    PublishAgendaCheckModel model,
  );

  Future<HttpResponse<String>> cancelAppointment(DataMap map);

  Future<HttpResponse<String>> removeSchedules({
    required List<String> scheduleIds,
  });

  Future<HttpResponse<List<AppointmentStatusModel>>> getAppointmentsTypes({
    required String doctorId,
  });

  Future<HttpResponse<List<MyAppointmentsClinicResponseModel>>>
      getAppointments({
    required String doctorId,
    required String statusId,
  });

  Future<HttpResponse<RescheduleResponseModel>> getReschedule({
    required String scheduleConsultationId,
  });

  Future<HttpResponse<String>> putReschedule({
    required ReschedulePutModel model,
  });
}

class ClinicRepository implements IClinicRepository {
  final HttpManager _httpManager;

  ClinicRepository(this._httpManager);

  @override
  Future<HttpResponse<String>> createClinic({
    required CreateClinicParams params,
  }) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic',
      method: HttpMethods.post,
      body: params.toJson(),
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<String>> createSpecialist({
    required CreateSpecialistParams params,
  }) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/specialist',
      method: HttpMethods.post,
      body: params.toJson(),
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<String>> updateSpecialist({
    required CreateSpecialistParams params,
  }) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/specialist',
      method: HttpMethods.put,
      body: params.toJson(),
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<List<SpecialistResponseModel>>> getMySpecialists() async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/specialist',
      method: HttpMethods.get,
      parser: (data) {
        return (data as List<dynamic>)
            .map((e) => SpecialistResponseModel.fromJson(e))
            .toList();
      },
    );
  }

  @override
  Future<HttpResponse<List<SpecialtyResponseModel>>> getSpecialties() async {
    return await _httpManager.request(
      path: '/api/v2/Specialtys',
      method: HttpMethods.get,
      parser: (data) {
        return (data as List<dynamic>)
            .map((e) => SpecialtyResponseModel.fromJson(e))
            .toList();
      },
    );
  }

  @override
  Future<HttpResponse<List<TypeScheduleResponse>>> getTypeSchedule() async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/typeSchedules',
      method: HttpMethods.get,
      parser: (data) {
        return (data as List<dynamic>)
            .map((e) => TypeScheduleResponse.fromJson(e))
            .toList();
      },
    );
  }

  @override
  Future<HttpResponse<String>> postPublishAgenda(
    PublishAgendaRequestModel model,
  ) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/schedule',
      method: HttpMethods.post,
      body: model.toJson(),
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<ScheduledDatesResponseModel>>
      getSchedulesFromSpecialistId({required String id}) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/schedule/$id',
      method: HttpMethods.get,
      parser: (data) {
        return ScheduledDatesResponseModel.fromJson(data);
      },
    );
  }

  @override
  Future<HttpResponse<String>> removeSchedules(
      {required List<String> scheduleIds}) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/schedule/',
      method: HttpMethods.delete,
      body: {'scheduleIds': scheduleIds},
      parser: (data) => data['message'],
    );
  }

  @override
  Future<HttpResponse<bool>> checkHour(PublishAgendaCheckModel model) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/schedule/validate',
      method: HttpMethods.post,
      body: model.toJson(),
      parser: (data) => data,
    );
  }

  @override
  Future<HttpResponse<List<AppointmentStatusModel>>> getAppointmentsTypes(
      {required String doctorId}) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/schedule/calendar/status/$doctorId',
      method: HttpMethods.get,
      parser: (data) {
        return (data as List<dynamic>)
            .map((e) => AppointmentStatusModel.fromJson(e))
            .toList();
      },
    );
  }

  @override
  Future<HttpResponse<List<MyAppointmentsClinicResponseModel>>> getAppointments(
      {required String doctorId, required String statusId}) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/schedule/calendar/dates/$doctorId/$statusId',
      method: HttpMethods.get,
      parser: (data) {
        return (data as List<dynamic>)
            .map((e) => MyAppointmentsClinicResponseModel.fromJson(e))
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
  Future<HttpResponse<RescheduleResponseModel>> getReschedule({
    required String scheduleConsultationId,
  }) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/reschedule/$scheduleConsultationId',
      method: HttpMethods.get,
      parser: (data) {
        return RescheduleResponseModel.fromJson(data);
      },
    );
  }

  @override
  Future<HttpResponse<String>> putReschedule({
    required ReschedulePutModel model,
  }) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/reschedule',
      method: HttpMethods.put,
      body: model.toJson(),
      parser: (data) => data['message'],
    );
  }
}
