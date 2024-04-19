/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

BridgeBean bridgeBeanFromJson(String str) => BridgeBean.fromJson(json.decode(str));

String bridgeBeanToJson(BridgeBean data) => json.encode(data.toJson());

class BridgeBean {
    BridgeBean({
        required this.countyCode,
        required this.locational,
        required this.objLatitude,
        required this.doubleBridge,
        required this.section,
        required this.longitudeStart,
        required this.builder,
        required this.widthMax,
        required this.longitudeEnd,
        required this.id,
        required this.totalLength,
        required this.area,
        required this.bridgeNameEng,
        required this.spans,
        required this.objLongitude,
        required this.nonBridge,
        required this.latitudeStart,
        required this.riverCross,
        required this.adm,
        required this.designer,
        required this.widthMin,
        required this.engineer,
        required this.structure,
        required this.bridgeName,
        required this.route,
        required this.bridgeId,
        required this.latitudeEnd,
        required this.areaCode,
        required this.inspectRate,
        required this.driveways,
    });

    int countyCode;  //所在縣市
    String locational;  //地標
    double objLatitude;
    String doubleBridge;  //是否??
    String section;  //轄下機關
    double longitudeStart;
    String builder;  //施工單位
    double widthMax;  //最大淨寬(公尺)
    double longitudeEnd;
    int id;
    double totalLength;  //橋梁總長(公尺)
    double area;  //??
    String bridgeNameEng;  //橋梁英文
    double spans;  //??
    double objLongitude;
    String nonBridge;  //橋的種類
    double latitudeStart;
    String riverCross;  //是否跨越河流
    String adm;  //管理機關
    String designer;  //設計單位
    double widthMin;  //最小淨寬(公尺)
    String engineer;  //監造單位
    String structure;  //建築風格
    String bridgeName;  //橋梁名稱
    String route;  //道路名稱
    String bridgeId;  //橋梁編號
    double latitudeEnd;
    int areaCode;  //所在區鄉
    int inspectRate;  //定期檢測週期(月/次)
    int driveways;  //總車道數

    factory BridgeBean.fromJson(Map<dynamic, dynamic> json) => BridgeBean(
        countyCode: json["CountyCode"],
        locational: json["locational"],
        objLatitude: json["Obj_Latitude"]?.toDouble(),
        doubleBridge: json["double_bridge"],
        section: json["section"],
        longitudeStart: json["Longitude_start"]?.toDouble(),
        builder: json["builder"],
        widthMax: json["width_max"]?.toDouble(),
        longitudeEnd: json["Longitude_end"]?.toDouble(),
        id: json["ID"],
        totalLength: json["total_length"]?.toDouble(),
        area: json["area"]?.toDouble(),
        bridgeNameEng: json["bridge_name_eng"],
        spans: json["spans"],
        objLongitude: json["Obj_Longitude"]?.toDouble(),
        nonBridge: json["non_bridge"],
        latitudeStart: json["Latitude_start"]?.toDouble(),
        riverCross: json["river_cross"],
        adm: json["adm"],
        designer: json["designer"],
        widthMin: json["width_min"]?.toDouble(),
        engineer: json["engineer"],
        structure: json["structure"],
        bridgeName: json["bridge_name"],
        route: json["route"],
        bridgeId: json["bridge_id"],
        latitudeEnd: json["Latitude_end"]?.toDouble(),
        areaCode: json["AreaCode"],
        inspectRate: json["inspect_rate"],
        driveways: json["driveways"],
    );

    Map<dynamic, dynamic> toJson() => {
        "CountyCode": countyCode,
        "locational": locational,
        "Obj_Latitude": objLatitude,
        "double_bridge": doubleBridge,
        "section": section,
        "Longitude_start": longitudeStart,
        "builder": builder,
        "width_max": widthMax,
        "Longitude_end": longitudeEnd,
        "ID": id,
        "total_length": totalLength,
        "area": area,
        "bridge_name_eng": bridgeNameEng,
        "spans": spans,
        "Obj_Longitude": objLongitude,
        "non_bridge": nonBridge,
        "Latitude_start": latitudeStart,
        "river_cross": riverCross,
        "adm": adm,
        "designer": designer,
        "width_min": widthMin,
        "engineer": engineer,
        "structure": structure,
        "bridge_name": bridgeName,
        "route": route,
        "bridge_id": bridgeId,
        "Latitude_end": latitudeEnd,
        "AreaCode": areaCode,
        "inspect_rate": inspectRate,
        "driveways": driveways,
    };
}
