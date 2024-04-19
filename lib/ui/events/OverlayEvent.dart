import 'package:buyandship_demo/beans/BridgeBean.dart';
import 'package:buyandship_demo/beans/TunnelBean.dart';
import 'package:buyandship_demo/http/GovApi.dart';

abstract class OverlayEvent {
}

class ShowLoading extends OverlayEvent {
}

class HideLoading extends OverlayEvent {
}