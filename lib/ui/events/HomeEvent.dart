import 'package:buyandship_demo/beans/BridgeBean.dart';
import 'package:buyandship_demo/beans/TunnelBean.dart';
import 'package:buyandship_demo/http/GovApi.dart';

abstract class HomeEvent {

}

class GetBridges extends HomeEvent {
  Future<bool> callApi(Function(List<BridgeBean>) onSuccess, Function(dynamic) onFailed) {
    GovApi api = GovApi();
    return api.getBridges(onSuccess, onFailed);
  }
}

class GetTunnels extends HomeEvent {
  Future<bool> callApi(Function(List<TunnelBean>) onSuccess, Function(dynamic) onFailed) {
    GovApi api = GovApi();
    return api.getTunnels(onSuccess, onFailed);
  }
}