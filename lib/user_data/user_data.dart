import 'package:e_learning/feature/login/student_login_data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

final userDataProvider = Provider<UserData>((ref) => UserData());

class UserData {
  final GetStorage userData = GetStorage('user');
  final GetStorage registeredData = GetStorage('registered');

  Future<void> addUserData(dynamic val) async {
    await userData.write('userData', val);
  }

  Future<void> addRegisteredData(Map val) async {
    await registeredData.write('registered', val);
  }

  StudentLoginDataModal get getUserData {
    final rawData = userData.read('userData');
    if (rawData == null || rawData is! Map) {
      return StudentLoginDataModal();
    }
    final data = Map<String, dynamic>.from(rawData);
    return StudentLoginDataModal.fromJson(data);
  }

  Future<void> removeUserData() async {
    await userData.remove('userData');
  }
}
