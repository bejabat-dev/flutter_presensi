import 'package:flutter_presensi/app/data/source/schedule_api_service.dart';
import 'package:flutter_presensi/app/module/entity/schedule.dart';
import 'package:flutter_presensi/app/module/repository/schedule_repository.dart';
import 'package:flutter_presensi/core/network/data_state.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleApiService _scheduleApiService;

  ScheduleRepositoryImpl(this._scheduleApiService);

  @override
  Future<DataState<ScheduleEntity?>> get() {
    return handleResponse(
      () => _scheduleApiService.get(),
      (json) {
        if (json != null) {
          return ScheduleEntity.fromJson(json);
        } else {
          return null;
        }
      },
    );
  }

  @override
  Future<DataState> banned() {
    return handleResponse(
      () => _scheduleApiService.banned(),
      (json) => null,
    );
  }
}
