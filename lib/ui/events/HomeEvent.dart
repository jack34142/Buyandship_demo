abstract class HomeEvent {}
class GetBridges extends HomeEvent {}
class GetTunnels extends HomeEvent {}
class OnBridgeTap extends HomeEvent {}
class OnTunnelTap extends HomeEvent {}

class OnTableSwitchTap extends HomeEvent {
  final int areaCode;
  OnTableSwitchTap(this.areaCode);
}