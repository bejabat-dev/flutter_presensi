import 'package:flutter_presensi/app/module/entity/schedule.dart';
import 'package:flutter_presensi/core/network/data_state.dart';

abstract class ScheduleRepository {
  Future<DataState<ScheduleEntity?>> get();
  Future<DataState> banned();
}
