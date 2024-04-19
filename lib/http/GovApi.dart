import 'dart:async';
import 'package:buyandship_demo/beans/BridgeBean.dart';
import 'package:buyandship_demo/beans/TunnelBean.dart';
import 'package:buyandship_demo/http/BaseHttp.dart';
import 'package:dio/dio.dart';

class GovApi extends BaseHttp {
  static final GovApi _singleton = GovApi._internal();

  factory GovApi() {
    return _singleton;
  }

  GovApi._internal();

  @override
  String get baseUrl => "https://tpnco.blob.core.windows.net";

  // 臺北市橋梁資訊 https://data.gov.tw/dataset/145817
  // https://tpnco.blob.core.windows.net/blobfs/Bridges.json
  Future<bool> getBridges(
      Function(List<BridgeBean>) onSuccess,
      Function(dynamic) onFailed
  ) async {
    Completer<bool> completer = Completer();
    Response response = await dio.get('/blobfs/Bridges.json');
    if(response.statusCode == 200 && response.data is List){
      List<BridgeBean> bridges = (response.data as List).map((e) => BridgeBean.fromJson(e)).toList();
      onSuccess(bridges);
      completer.complete(true);
    }else{
      onFailed(response.data.toString());
      completer.complete(false);
    }
    return completer.future;
  }

  // 臺北市隧道資訊 https://data.gov.tw/dataset/128938
  // https://tpnco.blob.core.windows.net/blobfs/Tunnels.json
  Future<bool> getTunnels(
      Function(List<TunnelBean>) onSuccess,
      Function(dynamic) onFailed
  ) async {
    Completer<bool> completer = Completer();
    Response response = await dio.get('/blobfs/Tunnels.json');
    if(response.statusCode == 200 && response.data is List){
      List<TunnelBean> tunnels = (response.data as List).map((e) => TunnelBean.fromJson(e)).toList();
      onSuccess(tunnels);
      completer.complete(true);
    }else{
      onFailed(response.data.toString());
      completer.complete(false);
    }
    return completer.future;
  }
}

