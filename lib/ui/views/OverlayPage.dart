
import 'package:buyandship_demo/ui/blocs/OverlayBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverlayPage extends StatelessWidget{

  static OverlayBloc bloc = OverlayBloc();

  final Widget child;

  const OverlayPage(this.child, {super.key});

  @override
  Widget build(context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<OverlayBloc, MyOverlayState>(builder: (context, state){
        return Stack(
          alignment:Alignment.center,
          children: [
            child,
            state.isLoading ? Container(
              height: double.infinity,
              width: double.infinity,
              color: const Color(0x66000000),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ) : Container()
          ],
        );
      }),
    );
  }
}