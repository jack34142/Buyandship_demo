import 'package:buyandship_demo/ui/BaseBloc.dart';
import 'package:buyandship_demo/http/GovApi.dart';
import 'package:buyandship_demo/ui/events/HomeEvent.dart';
import 'package:buyandship_demo/models/Bridge.dart';
import 'package:buyandship_demo/models/Tunnel.dart';

enum StructType{
  BRIDGE,
  TUNNEL,
  NONE
}

class HomeState {
  Map<int, bool> areaCodes = {};
  Map<int, List<Bridge>> bridges = {};
  Map<int, List<Tunnel>> tunnels = {};
  StructType selectedType = StructType.NONE;

  HomeState({HomeState? state}){
    if(state != null){
      areaCodes = state.areaCodes;
      bridges = state.bridges;
      tunnels = state.tunnels;
      selectedType = state.selectedType;
    }
  }
}

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super( HomeState()) {
    on<GetBridges>((event, emit) async {
      showLoading();
      GovApi api = GovApi();
      await api.getBridges((bridges){
        state.bridges = {};
        bridges.forEach((bridge) {
          if( !state.bridges.containsKey(bridge.areaCode) ){
            state.bridges[bridge.areaCode] = [];
            state.areaCodes[bridge.areaCode] = true;
          }
          state.bridges[bridge.areaCode]!.add(bridge);
        });
      }, onApiError);
      emit(HomeState(state: state));
      hideLoading();
    });

    on<GetTunnels>((event, emit) async {
      showLoading();
      GovApi api = GovApi();
      await api.getTunnels((tunnels){
        state.tunnels = {};
        tunnels.forEach((tunnel) {
          if( !state.tunnels.containsKey(tunnel.areaCode) ){
            state.tunnels[tunnel.areaCode] = [];
            state.areaCodes[tunnel.areaCode] = true;
          }
          state.tunnels[tunnel.areaCode]!.add(tunnel);
        });
      }, onApiError);
      emit(HomeState(state: state));
      hideLoading();
    });

    on<OnBridgeTap>((event, emit) async {
      if(state.selectedType != StructType.BRIDGE){
        state.selectedType = StructType.BRIDGE;
      }else{
        state.selectedType = StructType.NONE;
      }
      emit(HomeState(state: state));
    });

    on<OnTunnelTap>((event, emit) async {
      if(state.selectedType != StructType.TUNNEL){
        state.selectedType = StructType.TUNNEL;
      }else{
        state.selectedType = StructType.NONE;
      }
      emit(HomeState(state: state));
    });

    on<OnTableSwitchTap>((event, emit) async {
      state.areaCodes[event.areaCode] = !state.areaCodes[event.areaCode]!;
      emit(HomeState(state: state));
    });
  }
}