import 'package:buyandship_demo/base/BaseBloc.dart';
import 'package:buyandship_demo/ui/events/OverlayEvent.dart';

class MyOverlayState {
  int loadingCount = 0;
  String toastMsg = "";
  bool isToast = false;

  MyOverlayState({MyOverlayState? state}){
    if(state != null){
      loadingCount = state.loadingCount;
      toastMsg = state.toastMsg;
      isToast = state.isToast;
    }
  }
}

class OverlayBloc extends BaseBloc<OverlayEvent, MyOverlayState> {
  OverlayBloc() : super( MyOverlayState() ) {
    on<ShowLoading>((event, emit) async {
      state.loadingCount++;
      emit(MyOverlayState(state: state));
    });

    on<HideLoading>((event, emit) async {
      state.loadingCount--;
      emit(MyOverlayState(state: state));
    });

    on<ShowToast>((event, emit) async {
      state.toastMsg = event.msg;
      state.isToast = true;
      emit(MyOverlayState(state: state));

      await Future.delayed(Duration(milliseconds: 1500));
      state.isToast = false;
      emit(MyOverlayState(state: state));
    });
  }
}