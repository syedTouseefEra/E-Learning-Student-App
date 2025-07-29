import 'package:e_learning/components/alert_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardControllerProvider =
StateNotifierProvider<DashboardController, DashboardState>(
      (ref) => DashboardController(),
);

class DashboardState {
  final int requestType;

  DashboardState({this.requestType = 1});

  DashboardState copyWith({int? requestType}) {
    return DashboardState(
      requestType: requestType ?? this.requestType,
    );
  }

  bool get isTopicView => requestType == 1;
}


class DashboardController extends StateNotifier<DashboardState> {
  DashboardController() : super(DashboardState());

  void changeViewType(int value) {
    state = state.copyWith(requestType: value);
    AlertView().alertToast("View Changed to ${isTopicView ? "Topic" : "Module"}");
  }

  int get requestType => state.requestType;

  bool get isTopicView => state.requestType == 1;
}
