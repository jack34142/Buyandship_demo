import 'dart:async';
import 'package:buyandship_demo/http/BaseHttp.dart';
import 'package:buyandship_demo/models/Bridge.dart';
import 'package:buyandship_demo/models/Tunnel.dart';

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
      Function(List<Bridge>) onSuccess,
      Function(dynamic) onFailed
  ) async {
    Completer<bool> completer = Completer();
    dio.get('/blobfs/Bridges.json').then((response){
      if(response.statusCode == 200 && response.data is List){
        List<Bridge> bridges = (response.data as List).map((e) => Bridge.fromJson(e)).toList();
        onSuccess(bridges);
        completer.complete(true);
      }else{
        onFailed(response.data.toString());
        completer.complete(false);
      }
    }).catchError((e){
      onFailed(e.toString());
      completer.complete(false);
    });
    return completer.future;
  }

  // 臺北市隧道資訊 https://data.gov.tw/dataset/128938
  // https://tpnco.blob.core.windows.net/blobfs/Tunnels.json
  Future<bool> getTunnels(
      Function(List<Tunnel>) onSuccess,
      Function(dynamic) onFailed
  ) async {
    Completer<bool> completer = Completer();
    dio.get('/blobfs/Tunnels.json').then((response){
      if(response.statusCode == 200 && response.data is List){
        List<Tunnel> tunnels = (response.data as List).map((e) => Tunnel.fromJson(e)).toList();
        onSuccess(tunnels);
        completer.complete(true);
      }else{
        onFailed(response.data.toString());
        completer.complete(false);
      }
    }).catchError((e){
      onFailed(e.toString());
      completer.complete(false);
    });
    return completer.future;
  }
}

