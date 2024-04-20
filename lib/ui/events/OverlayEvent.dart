abstract class OverlayEvent {}
class ShowLoading extends OverlayEvent {}
class HideLoading extends OverlayEvent {}

class ShowToast extends OverlayEvent {
  final String msg;
  ShowToast(this.msg);
}