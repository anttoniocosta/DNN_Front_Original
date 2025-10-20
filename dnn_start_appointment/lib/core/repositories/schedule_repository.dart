import 'package:dnn_shared/dnn_shared.dart';

abstract class IScheduleRepository {
  Future<HttpResponse<List<ScheduleFilterSpecialtyResponse>>>
      getFilterSpecialties({
    required int typeScheduleId,
    required bool isReadyService,
  });
  Future<HttpResponse<List<ScheduleFilterDaysResponse>>> getFilterDays({
    required int typeScheduleId,
    required int specialtyId,
    required bool isReadyService,
    required String state,
  });
  Future<HttpResponse<List<ScheduleFilterHourResponse>>> getFilterHours({
    required int typeScheduleId,
    required int specialtyId,
    required bool isReadyService,
    required String date,
    required String state,
  });

  Future<HttpResponse<List<TypeScheduleResponse>>> getTypeSchedule();

  Future<HttpResponse<ScheduleSuccessResponseModel>> schedule({
    required SchedulePaymentRequestModel schedule,
  });
}

class ScheduleRepository implements IScheduleRepository {
  final HttpManager _httpManager;

  ScheduleRepository(this._httpManager);

  @override
  Future<HttpResponse<List<ScheduleFilterSpecialtyResponse>>>
      getFilterSpecialties({
    required int typeScheduleId,
    required bool isReadyService,
  }) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/filter/specialtys/$typeScheduleId/$isReadyService',
      method: HttpMethods.get,
      parser: (data) => (data as List<dynamic>)
          .map((e) => ScheduleFilterSpecialtyResponse.fromJson(e))
          .toList(),
    );
  }

  @override
  Future<HttpResponse<List<ScheduleFilterDaysResponse>>> getFilterDays({
    required int typeScheduleId,
    required bool isReadyService,
    required int specialtyId,
    required String state,
  }) async {
    return await _httpManager.request(
      path:
          '/api/v2/Clinic/filter/specialtys/schedule/$typeScheduleId/$isReadyService/$specialtyId/$state',
      method: HttpMethods.get,
      parser: (data) => (data as List<dynamic>)
          .map((e) => ScheduleFilterDaysResponse.fromJson(e))
          .toList(),
    );
  }

  @override
  Future<HttpResponse<List<ScheduleFilterHourResponse>>> getFilterHours({
    required int typeScheduleId,
    required int specialtyId,
    required bool isReadyService,
    required String date,
    required String state,
  }) async {
    return await _httpManager.request(
      path:
          '/api/v2/Clinic/filter/specialtys/schedule/dates/$typeScheduleId/$isReadyService/$specialtyId/$state/$date',
      method: HttpMethods.get,
      parser: (data) => (data as List<dynamic>)
          .map((e) => ScheduleFilterHourResponse.fromJson(e))
          .toList(),
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
  Future<HttpResponse<ScheduleSuccessResponseModel>> schedule({
    required SchedulePaymentRequestModel schedule,
  }) async {
    return await _httpManager.request(
      path: '/api/v2/Clinic/schedule/buy',
      method: HttpMethods.post,
      body: schedule.toJson(),
      parser: (data) => ScheduleSuccessResponseModel.fromJson(data),
    );
  }
}
