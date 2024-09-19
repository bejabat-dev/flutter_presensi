import 'package:flutter_presensi/app/module/entity/attendance.dart';
import 'package:flutter_presensi/app/module/use_case/attendance_get_by_month_year.dart';
import 'package:flutter_presensi/core/provider/app_provider.dart';
import 'package:flutter/material.dart';

class DetailAttendanceNotifier extends AppProvider {
  final AttendanceGetByMonthYear _attendanceGetByMonthYear;

  DetailAttendanceNotifier(this._attendanceGetByMonthYear) {
    init();
  }

  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final List<DropdownMenuEntry<int>> _monthListDropdown = [
    const DropdownMenuEntry<int>(value: 1, label: 'Januari'),
    const DropdownMenuEntry<int>(value: 2, label: 'February'),
    const DropdownMenuEntry<int>(value: 3, label: 'Maret'),
    const DropdownMenuEntry<int>(value: 4, label: 'April'),
    const DropdownMenuEntry<int>(value: 5, label: 'Mei'),
    const DropdownMenuEntry<int>(value: 6, label: 'Juni'),
    const DropdownMenuEntry<int>(value: 7, label: 'Juli'),
    const DropdownMenuEntry<int>(value: 8, label: 'Agustus'),
    const DropdownMenuEntry<int>(value: 9, label: 'September'),
    const DropdownMenuEntry<int>(value: 10, label: 'Oktober'),
    const DropdownMenuEntry<int>(value: 11, label: 'November'),
    const DropdownMenuEntry<int>(value: 12, label: 'Desember')
  ];
  final List<DropdownMenuEntry<int>> _yearListDropdown = [
    const DropdownMenuEntry<int>(value: 2024, label: '2024')
  ];

  List<AttendanceEntity> _listAttendance = [];

  TextEditingController get monthController => _monthController;
  TextEditingController get yearController => _yearController;

  List<DropdownMenuEntry<int>> get monthListDropdown => _monthListDropdown;
  List<DropdownMenuEntry<int>> get yearListDropdown => _yearListDropdown;

  List<AttendanceEntity> get listAttendance => _listAttendance;

  @override
  void init() {
    // TODO: implement init
  }

  search() async {
    showLoading();
    final month = _monthListDropdown
        .where((element) => element.label == _monthController.text)
        .first
        .value;
    final year = _yearListDropdown
        .where((element) => element.label == _yearController.text)
        .first
        .value;

    final response = await _attendanceGetByMonthYear(
        param: AttendanceParamGetEntity(month: month, year: year));
    if (response.success) {
      _listAttendance = response.data!;
    } else {
      errorMeesage = response.message;
    }
    hideLoading();
  }
}
