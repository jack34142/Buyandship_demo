import 'package:buyandship_demo/ui/blocs/OverlayBloc.dart';
import 'package:buyandship_demo/ui/events/OverlayEvent.dart';
import 'package:buyandship_demo/ui/temeplates/dialogs/MsgDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBloc<T, V> extends Bloc<T, V> {
  OverlayBloc? _overlayBloc;

  Function(String)? showMsg;

  BaseBloc(super.initialState);

  init(BuildContext context){
    _overlayBloc = context.read<OverlayBloc>();
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
    _overlayBloc?.add(ShowLoading());
  }

  hideLoading(){
    _overlayBloc?.add(HideLoading());
  }

  showToast(String msg){
    _overlayBloc?.add(ShowToast(msg));
  }
}