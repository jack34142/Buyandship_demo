import 'dart:io';
import 'package:buyandship_demo/configs/MyColors.dart';
import 'package:buyandship_demo/ui/blocs/HomeBloc.dart';
import 'package:buyandship_demo/ui/events/HomeEvent.dart';
import 'package:buyandship_demo/models/Bridge.dart';
import 'package:buyandship_demo/models/Tunnel.dart';
import 'package:buyandship_demo/ui/temeplates/buttons/CheckButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomePage extends StatelessWidget {
  late HomeBloc bloc;

  final ItemScrollController _areaCodeScrollController = ItemScrollController();
  final ItemPositionsListener _areaCodePositionListener = ItemPositionsListener.create();

  int _lastBackPress = 0;
  bool _scrolling = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        bloc = HomeBloc();
        bloc.init(context);
        bloc.add(GetBridges());
        bloc.add(GetTunnels());
        return bloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state){
        return Scaffold(
          body: PopScope(
            canPop: false,
            onPopInvoked: (didPop) => _onBackPress(),
            child: SafeArea(
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      bloc.add(GetBridges());
                      bloc.add(GetTunnels());
                      return;
                    },
                    child: state.areaCodes.isNotEmpty ? ScrollablePositionedList.builder(
                        padding: EdgeInsets.only(bottom: 180),
                        itemScrollController: _areaCodeScrollController,
                        itemPositionsListener: _areaCodePositionListener,
                        itemCount: state.areaCodes.length,
                        itemBuilder: (context, index){
                          int areaCode = state.areaCodes.keys.elementAt(index);
                          bool isOpen = state.areaCodes[areaCode]!;
                          List<Bridge>? bridges = state.bridges[areaCode];
                          List<Tunnel>? tunnels = state.tunnels[areaCode];
                          int bridgeCount = bridges != null ? bridges.length : 0;
                          int tunnelCount = tunnels != null ? tunnels.length : 0;
                          return StickyHeader(
                              header: Container(
                                padding: EdgeInsets.only(left: 11, top: 7, bottom: 4, right: 2),
                                width: double.infinity,
                                color: MyColors.bg_default,
                                child: Row(
                                  children: [
                                    Expanded(child: Text(areaCode.toString(), style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19
                                    ))),
                                    CheckButton(Text("橋樑($bridgeCount)"),
                                        isSelect: state.selectedType == StructType.BRIDGE,
                                        onPressed: (){
                                          if(!_scrolling){
                                            if( !isOpen ){
                                              bloc.add(OnTableSwitchTap(areaCode));
                                            }
                                            bloc.add(OnBridgeTap());
                                            _scrollTo(index);
                                          }
                                        }
                                    ),
                                    Container(width: 4,),
                                    CheckButton(Text("隧道($tunnelCount)"),
                                        isSelect: state.selectedType == StructType.TUNNEL,
                                        onPressed: (){
                                          if(!_scrolling){
                                            if( !isOpen ){
                                              bloc.add(OnTableSwitchTap(areaCode));
                                            }
                                            bloc.add(OnTunnelTap());
                                            _scrollTo(index);
                                          }
                                        }
                                    ),
                                    IconButton(
                                        onPressed: (){
                                          if(!_scrolling){
                                            bloc.add(OnTableSwitchTap(areaCode));
                                            _scrollTo(index);
                                          }
                                        },
                                        icon: isOpen ? Icon(Icons.remove) : Icon(Icons.expand_more)
                                    )
                                  ],
                                ),
                              ),
                              content: isOpen ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bridges != null && state.selectedType != StructType.TUNNEL ? _buildBridge(bridges) : Container(),
                                  tunnels != null && state.selectedType != StructType.BRIDGE  ? _buildTunnel(tunnels) : Container(),
                                ],
                              ) : Container()
                          );
                        }
                    ) : ListView(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(top: 12),
                          width: double.infinity,
                          child: Text("下拉刷新", style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 35,
                    bottom: 35,
                    child: _buildFloatingButton(state.areaCodes.length-1)
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBridge(List<Bridge> bridges){
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: bridges.length,
        itemBuilder: (conteext, index){
          Bridge bridge = bridges[index];
          return Container(
            margin: EdgeInsets.only(left: 14, right: 14, bottom: 15),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              clipBehavior: Clip.hardEdge,
              color: MyColors.green_linen,
              elevation: 6,
              child: Column(
                children: [
                  _buildTableTitle(bridge.bridgeName, MyColors.green_beryl, secondTitle: bridge.bridgeNameEng),
                  _buildTableItem("類型", "${bridge.nonBridge} (${bridge.structure})"),
                  _buildTableItem("管理幾關", "${bridge.adm} ${bridge.section}"),
                  _buildTableItem("位置", "${bridge.route} (${bridge.locational})"),
                  _buildTableItem("設計單位", "${bridge.designer}"),
                  _buildTableItem("監造單位", "${bridge.engineer}"),
                  _buildTableItem("施工單位", "${bridge.builder}"),
                  _buildTableItem("定期檢測週期(月/次)", "${bridge.inspectRate}"),
                  _buildTableItem("總車道數", "${bridge.driveways}"),
                  _buildTableItem("最小淨寬(公尺)", "${bridge.widthMin}"),
                  _buildTableItem("最大淨寬(公尺)", "${bridge.widthMax}"),
                  _buildTableItem("橋梁總長(公尺)", "${bridge.totalLength}"),
                  Container(height: 7)
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _buildTunnel(List<Tunnel> tunnels){
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: tunnels.length,
        itemBuilder: (conteext, index){
          Tunnel tunnel = tunnels[index];
          return Container(
            margin: EdgeInsets.only(left: 14, right: 14, bottom: 15),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              clipBehavior: Clip.hardEdge,
              color: MyColors.orange_yellow_dust,
              elevation: 6,
              child: Column(
                children: [
                  _buildTableTitle(tunnel.tunnelName, MyColors.orange_yellow),
                  _buildTableItem("類型", "${tunnel.tunnelKind}"),
                  _buildTableItem("管理幾關", "${tunnel.adminUnit}"),
                  _buildTableItem("位置", "${tunnel.route}"),
                  _buildTableItem("設計單位", "${tunnel.designEngineers}"),
                  _buildTableItem("監造單位", "${tunnel.superviseEngineers}"),
                  _buildTableItem("施工單位", "${tunnel.buildEngineers}"),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tunnel.lines.length,
                      itemBuilder: (context, index){
                        Line line = tunnel.lines[index];
                        return Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Divider(),
                            Text(line.doubleName, style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),
                            _buildTableItem("總車道數", "${line.driveWay}"),
                            _buildTableItem("隧道限高等資訊", "${line.dnHeight}"),
                            _buildTableItem("隧道長度", "${line.totalLength}"),
                            _buildTableItem("隧道寬度", "${line.tunnelWidth}"),
                            _buildTableItem("隧道高度", "${line.tunnelHeight}"),
                            _buildTableItem("隧道面積", "${line.area}"),
                          ],
                        );
                      }
                  ),
                  Container(height: 7)
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _buildTableTitle(String title, Color bgColor, {String secondTitle = ""}){
    return Container(
      width: double.infinity,
      color: bgColor,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 6),
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(
              fontWeight: FontWeight.bold
          )),
          secondTitle.isNotEmpty ? Text(secondTitle, style: TextStyle(
              fontSize: 11
          )) : Container()
        ],
      ),
    );
  }

  Widget _buildTableItem(String key, String value){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 2),
      child: Row(
        children: [
          Text(key),
          Expanded(child: Text(value, textAlign: TextAlign.right))
        ],
      ),
    );
  }

  Widget _buildFloatingButton(int maxIndex){
    return Column(
      children: [
        FloatingActionButton(
            child: Icon(Icons.arrow_upward, color: MyColors.text_darkbg),
            shape: CircleBorder(),
            backgroundColor: MyColors.primary,
            onPressed: () async {
              if( !_scrolling ){
                int min = _areaCodePositionListener.itemPositions.value.reduce((a, b) => a.index > b.index ? b : a).index;
                if(min == 0){
                  bloc.showToast("已經到頂了");
                }else{
                  min--;
                }
                _scrollTo(min);
              }
            }
        ),
        Container(height: 10),
        FloatingActionButton(
            child: Icon(Icons.arrow_downward, color: MyColors.text_darkbg),
            shape: CircleBorder(),
            backgroundColor: MyColors.primary,
            onPressed: () async {
              if( !_scrolling ){
                int max = _areaCodePositionListener.itemPositions.value.reduce((a, b) => a.index < b.index ? b : a).index;
                if(max == maxIndex){
                  bloc.showToast("已經到底了");
                }else{
                  max++;
                }
                _scrollTo(max);
              }
            }
        )
      ],
    );
  }

  // ------------------------------
  void _scrollTo(int index) async {
    if( !_scrolling ){
      _scrolling = true;
      await Future.delayed(Duration(milliseconds: 10));  //等ui渲染完畢
      await _areaCodeScrollController.scrollTo(index: index, duration: Duration(milliseconds: 500));
      _scrolling = false;
    }
  }

  void _onBackPress(){
    int now = DateTime.timestamp().millisecondsSinceEpoch;
    if(now - _lastBackPress < 1500){
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    }else{
      _lastBackPress = now;
      bloc.showToast("再次返回退出應用");
    }
  }
}