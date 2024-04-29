/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

Tunnel TunnelFromJson(String str) => Tunnel.fromJson(json.decode(str));

String TunnelToJson(Tunnel data) => json.encode(data.toJson());

class Tunnel {
    Tunnel({
        required this.countyCode,
        required this.tunnelKind,
        required this.buildEngineers,
        required this.tunnelId,
        required this.objLongitude,
        required this.objLatitude,
        required this.tunnelName,
        required this.superviseEngineers,
        required this.adminUnit,
        required this.designEngineers,
        required this.areaCode,
        required this.id,
        required this.route,
        required this.lines,
    });

    int countyCode;  //所在縣市
    String tunnelKind;  //隧道類型(單線/雙線)
    String buildEngineers;  //施工單位
    String tunnelId;  //隧道編號
    double objLongitude;
    double objLatitude;
    String tunnelName;  //隧道名稱
    String superviseEngineers;  //監造單位
    String adminUnit;  //轄下機關
    String designEngineers;  //設計單位
    int areaCode;  //所在區鄉
    int id;
    String route;  //道路名稱
    List<Line> lines;  //多向線

    factory Tunnel.fromJson(Map<dynamic, dynamic> json) => Tunnel(
        countyCode: json["CountyCode"],
        tunnelKind: json["TunnelKind"],
        buildEngineers: json["BuildEngineers"],
        tunnelId: json["tunnel_id"],
        objLongitude: json["Obj_Longitude"]?.toDouble(),
        objLatitude: json["Obj_Latitude"]?.toDouble(),
        tunnelName: json["tunnel_name"],
        superviseEngineers: json["SuperviseEngineers"],
        adminUnit: json["AdminUnit"],
        designEngineers: json["DesignEngineers"],
        areaCode: json["AreaCode"],
        id: json["ID"],
        route: json["Route"],
        lines: List<Line>.from(json["Lines"].map((x) => Line.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "CountyCode": countyCode,
        "TunnelKind": tunnelKind,
        "BuildEngineers": buildEngineers,
        "tunnel_id": tunnelId,
        "Obj_Longitude": objLongitude,
        "Obj_Latitude": objLatitude,
        "tunnel_name": tunnelName,
        "SuperviseEngineers": superviseEngineers,
        "AdminUnit": adminUnit,
        "DesignEngineers": designEngineers,
        "AreaCode": areaCode,
        "ID": id,
        "Route": route,
        "Lines": List<dynamic>.from(lines.map((x) => x.toJson())),
    };
}

class Line {
    Line({
        required this.doubleNo,
        required this.totalLength,
        required this.area,
        required this.longitudeStart,
        required this.driveWay,
        required this.tunnelHeight,
        required this.doubleName,
        required this.latitudeStart,
        required this.latitudeEnd,
        required this.longitudeEnd,
        required this.dnHeight,
        required this.tunnelWidth,
    });

    String doubleNo;
    double totalLength;  //隧道長度
    double area;  //隧道面積
    double longitudeStart;
    int driveWay;  //車道數
    double tunnelHeight;  //隧道高度
    String doubleName;  //多向線名稱
    double latitudeStart;
    double latitudeEnd;
    double longitudeEnd;
    double dnHeight;  //隧道限高等資訊
    double tunnelWidth;  //隧道寬度

    factory Line.fromJson(Map<dynamic, dynamic> json) => Line(
        doubleNo: json["DoubleNo"],
        totalLength: json["TotalLength"],
        area: json["Area"],
        longitudeStart: json["Longitude_start"]?.toDouble(),
        driveWay: json["DriveWay"],
        tunnelHeight: json["TunnelHeight"]?.toDouble(),
        doubleName: json["DoubleName"],
        latitudeStart: json["Latitude_start"]?.toDouble(),
        latitudeEnd: json["Latitude_end"]?.toDouble(),
        longitudeEnd: json["Longitude_end"]?.toDouble(),
        dnHeight: json["DnHeight"]?.toDouble(),
        tunnelWidth: json["TunnelWidth"],
    );

    Map<dynamic, dynamic> toJson() => {
        "DoubleNo": doubleNo,
        "TotalLength": totalLength,
        "Area": area,
        "Longitude_start": longitudeStart,
        "DriveWay": driveWay,
        "TunnelHeight": tunnelHeight,
        "DoubleName": doubleName,
        "Latitude_start": latitudeStart,
        "Latitude_end": latitudeEnd,
        "Longitude_end": longitudeEnd,
        "DnHeight": dnHeight,
        "TunnelWidth": tunnelWidth,
    };
}
