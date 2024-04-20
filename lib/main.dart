import 'package:buyandship_demo/configs/MyColors.dart';
import 'package:buyandship_demo/ui/views/HomePage.dart';
import 'package:buyandship_demo/ui/views/OverlayPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  if (!kDebugMode) {  //release mode 自動禁用 debugPrint
    debugPrint = (String? message, {int? wrapWidth}) => null;
  }

  // Bloc.observer = const AppBlocObserver();
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      scaffoldBackgroundColor: MyColors.bg_default
    ),
    builder: (context, child){
      return OverlayPage(child!);  //OverlayPage做全域使用的view, 目前有loading跟toast
    },
  ));
}

/// {@template app_bloc_observer}
/// Custom [BlocObserver] that observes all bloc and cubit state changes.
/// {@endtemplate}
class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc,
      Transition<dynamic, dynamic> transition,
      ) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
