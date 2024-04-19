import 'package:buyandship_demo/beans/BridgeBean.dart';
import 'package:buyandship_demo/beans/TunnelBean.dart';
import 'package:buyandship_demo/ui/blocs/HomeBloc.dart';
import 'package:buyandship_demo/ui/events/HomeEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_){
        HomeBloc bloc = HomeBloc();
        bloc.add(GetBridges());
        bloc.add(GetTunnels());
        return bloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state){
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(child: ListView.builder(
                  itemCount: state.areaCodes.length,
                  itemBuilder: (context, index){
                    int areaCode = state.areaCodes.elementAt(index);
                    List<BridgeBean>? bridges = state.bridges[areaCode];
                    List<TunnelBean>? tunnels = state.tunnels[areaCode];
                    return Column(
                      children: [
                        Text(areaCode.toString()),
                        bridges != null ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: bridges.length,
                          itemBuilder: (conteext, index){
                            return Text(bridges[index].bridgeName);
                          }
                        ) : Container(),
                        tunnels != null ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: tunnels.length,
                            itemBuilder: (conteext, index){
                              return Text(tunnels[index].tunnelName);
                            }
                        ) : Container(),
                      ],
                    );
                  }
                ))
              ],
            ),
          ),
        );
      }),
    );
  }
}