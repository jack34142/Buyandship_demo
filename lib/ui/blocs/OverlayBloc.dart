import 'package:buyandship_demo/base/BaseBloc.dart';
import 'package:buyandship_demo/ui/events/OverlayEvent.dart';

class MyOverlayState {
  bool isLoading = false;
}

class OverlayBloc extends BaseBloc<OverlayEvent, MyOverlayState> {
  OverlayBloc() : super( MyOverlayState() ) {
    on<ShowLoading>((event, emit) async {
      state.isLoading = true;
      // await Future.delayed(const Duration(milliseconds: 1000));
      // if(eventEnd()){
      //   print("AAAA");
        emit(state);
      // }
    });
    on<HideLoading>((event, emit) async {
      state.isLoading = false;
      // await Future.delayed(const Duration(milliseconds: 1000));
      // if(eventEnd()){
      //   print("BBBB" + state.isLoading.toString());
        emit(state);
      // }
    });
  }
}