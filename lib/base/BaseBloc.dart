import 'package:buyandship_demo/ui/events/OverlayEvent.dart';
import 'package:buyandship_demo/ui/views/OverlayPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBloc<T, V> extends Bloc<T, V> {
  BaseBloc(super.initialState);

  int loadingCount = 0;
  int emitTimer = 0;
  int waitEvent = 0;

  onApiError(dynamic error){
    debugPrint(error);
  }

  showLoading(){
    loadingCount++;
    OverlayPage.bloc.add(ShowLoading());
  }

  hideLoading(){
    if(loadingCount > 0){
      loadingCount--;
    }
    if(loadingCount == 0){
      OverlayPage.bloc.add(HideLoading());
      return true;
    }else{
      return false;
    }
  }

  @override
  void add(T event) {
    super.add(event);
    waitEvent++;
  }

  @override
  void emit(V state) {
    if(waitEvent > 0){
      waitEvent--;
    }
    if(waitEvent == 0){
      super.emit(state);
    }
  }
}