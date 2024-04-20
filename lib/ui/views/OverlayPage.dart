import 'package:buyandship_demo/ui/blocs/OverlayBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverlayPage extends StatelessWidget{

  static final OverlayBloc bloc = OverlayBloc();

  final Widget child;

  const OverlayPage(this.child, {super.key});

  @override
  Widget build(context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<OverlayBloc, MyOverlayState>(
        builder: (context, state){
          return Stack(
            alignment:Alignment.center,
            children: [
              child,
              state.loadingCount > 0 ? Container(
                height: double.infinity,
                width: double.infinity,
                color: const Color(0x66000000),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ) : Container(),
              Positioned(  // toast
                bottom: MediaQuery.of(context).size.height * 0.1,
                child: AnimatedOpacity(
                  opacity: state.isToast ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: IgnorePointer(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                      // margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                      decoration: const BoxDecoration(
                          color: Color(0x88000000),
                          borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: Text(state.toastMsg,
                        // softWrap: true,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}