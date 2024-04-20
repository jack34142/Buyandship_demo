import 'package:buyandship_demo/ui/events/OverlayEvent.dart';
import 'package:buyandship_demo/ui/temeplates/dialogs/MsgDialog.dart';
import 'package:buyandship_demo/ui/views/OverlayPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBloc<T, V> extends Bloc<T, V> {

  Function(String)? showMsg;

  BaseBloc(super.initialState);

  init(BuildContext context){
    showMsg = (msg){
      showDialog(
        context: context,
        builder: (context){
          return MsgDialog(msg);
        }
      );
    };
  }

  onApiError(dynamic error){
    debugPrint(error.toString());
    if(showMsg != null){
      showMsg!(error.toString());
    }
  }

  showLoading(){
    OverlayPage.bloc.add(ShowLoading());
  }

  hideLoading(){
    OverlayPage.bloc.add(HideLoading());
  }

  showToast(String msg){
    OverlayPage.bloc.add(ShowToast(msg));
  }
}