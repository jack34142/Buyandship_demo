import 'package:buyandship_demo/base/BaseBloc.dart';
import 'package:buyandship_demo/beans/BridgeBean.dart';
import 'package:buyandship_demo/beans/TunnelBean.dart';
import 'package:buyandship_demo/ui/events/HomeEvent.dart';

class HomeState {
  Set<int> areaCodes = Set();
  Map<int, List<BridgeBean>> bridges = {};
  Map<int, List<TunnelBean>> tunnels = {};
  // Map<int, Map<int, dynamic>> bridgeAndTunnels = {};  // dynamic 包含 BridgeBean 跟 TunnelBean
}

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super( HomeState() ) {
    on<GetBridges>((event, emit) async {
      // showLoading();
      await event.callApi((bridges){
        state.bridges = {};
        bridges.forEach((bridge) {
          if( !state.bridges.containsKey(bridge.areaCode) ){
            state.bridges[bridge.areaCode] = [];
            state.areaCodes.add(bridge.areaCode);
          }
          state.bridges[bridge.areaCode]!.add(bridge);
        });
      }, onApiError);
      emit(state);
      // hideLoading();
    });
    on<GetTunnels>((event, emit) async {
      // showLoading();
      await event.callApi((tunnels){
        state.tunnels = {};
        tunnels.forEach((tunnel) {
          if( !state.tunnels.containsKey(tunnel.areaCode) ){
            state.tunnels[tunnel.areaCode] = [];
            state.areaCodes.add(tunnel.areaCode);
          }
          state.tunnels[tunnel.areaCode]!.add(tunnel);
        });
      }, onApiError);
      emit(state);
      // hideLoading();
    });
  }
}