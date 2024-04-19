import 'package:buyandship_demo/ui/views/HomePage.dart';
import 'package:buyandship_demo/ui/views/OverlayPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // Bloc.observer = const AppBlocObserver();
  runApp(MaterialApp(
    home: HomePage(),
    builder: (context, child){
      return OverlayPage(child!);
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
