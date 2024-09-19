import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_presensi/app/module/entity/attendance.dart';
import 'package:flutter_presensi/app/module/entity/schedule.dart';
import 'package:flutter_presensi/app/module/use_case/attendance_get_this_month.dart';
import 'package:flutter_presensi/app/module/use_case/attendance_get_today.dart';
import 'package:flutter_presensi/app/module/use_case/schedule_banned.dart';
import 'package:flutter_presensi/app/module/use_case/schedule_get.dart';
import 'package:flutter_presensi/core/helper/shared_preference_helper.dart';
import 'package:flutter_presensi/core/provider/app_provider.dart';
import 'package:flutter_presensi/core/constant/constant.dart';


class HomeNotifier extends AppProvider {
  final AttendanceGetTodayUseCase _attendanceGetTodayUseCase;
  final AttendanceGetMonthUseCase _attendanceGetMonthUseCase;
  final ScheduleGetUseCase _scheduleGetUseCase;
  final ScheduleBannedUseCase _scheduleBannedUseCase;

  HomeNotifier(this._attendanceGetTodayUseCase, this._attendanceGetMonthUseCase,
      this._scheduleGetUseCase, this._scheduleBannedUseCase) {
    init();
  }

  String _name = '';
  bool _isPhysicDevice = true;
  AttendanceEntity? _attendanceToday;
  List<AttendanceEntity> _listAttendanceThisMonth = [];
  ScheduleEntity? _schedule;
  bool _isLeaves = false;

  String get name => _name;
  bool get isPhysicDevice => _isPhysicDevice;
  AttendanceEntity? get attendanceToday => _attendanceToday;
  List<AttendanceEntity> get listAttendanceThisMonth =>
      _listAttendanceThisMonth;
  ScheduleEntity? get schedule => _schedule;
  bool get isLeaves => _isLeaves;

  @override
  void init() async {
    await _getUserDetail();
    // await _getDeviceInfo();
    if (errorMessage.isEmpty) await _getAttendanceToday();
    if (errorMessage.isEmpty) await _getAttendanceThisMonth();
    if (errorMessage.isEmpty) await _getSchedule();
  }

  _getUserDetail() async {
    showLoading();
    _name = await SharedPreferencesHelper.getString(PREF_NAME);
    hideLoading();
  }

  _getDeviceInfo() async {
    showLoading();
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      _isPhysicDevice = androidInfo.isPhysicalDevice;
    } else if (Platform.isIOS) {
      final iOSInfo = await DeviceInfoPlugin().iosInfo;
      _isPhysicDevice = iOSInfo.isPhysicalDevice;
    }

    if (!_isPhysicDevice) _sendBanned();
    hideLoading();
  }

  _getAttendanceToday() async {
    showLoading();
    final response = await _attendanceGetTodayUseCase();
    if (response.success) {
      _attendanceToday = response.data;
    } else {
      errorMeesage = response.message;
    }

    hideLoading();
  }

  _getAttendanceThisMonth() async {
    showLoading();
    final response = await _attendanceGetMonthUseCase();
    if (response.success) {
      _listAttendanceThisMonth = response.data!;
    } else {
      errorMeesage = response.message;
    }
    hideLoading();
  }

  _getSchedule() async {
    showLoading();
    _isLeaves = false;
    final response = await _scheduleGetUseCase();
    if (response.success) {
      if (response.data != null) {
        _schedule = response.data!;
      } else {
        _isLeaves = true;
        snackbarMessage = response.message;
      }
    } else {
      errorMeesage = response.message;
    }
    hideLoading();
  }

  _sendBanned() async {
    showLoading();
    final response = await _scheduleBannedUseCase();
    if (response.success) {
      _getSchedule();
    } else {
      errorMeesage = response.message;
    }
    hideLoading();
  }
}

