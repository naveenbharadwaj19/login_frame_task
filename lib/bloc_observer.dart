

import 'dart:developer';

import 'package:bloc/bloc.dart';

class BlocCubitObserver  extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created : $bloc");
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed: $bloc");
    super.onClose(bloc);
  }
}