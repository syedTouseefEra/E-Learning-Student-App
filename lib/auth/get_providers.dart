import 'package:e_learning/feature/classes_dashboard/class_dashboard_data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenProvider = StateProvider<String?>((ref) => null);
final instituteId = StateProvider<String?>((ref) => null);
final studentIdProvider = StateProvider<String?>((ref) => null);
final instituteIdProvider = StateProvider<String?>((ref) => null);
final selectedSubjectProvider = StateProvider<String?>((ref) => null);
final selectedClassProvider = StateProvider<ClassDashboardDataModel?>((ref) => null);
final sessionIdProvider = StateProvider<String?>((ref) => null);

final isAssignmentProvider = StateProvider<bool?>((ref) => null);

final startDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final endDateProvider = StateProvider<DateTime>((ref) => DateTime.now());