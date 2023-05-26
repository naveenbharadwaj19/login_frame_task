import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_frame_task/bloc_observer.dart';
import 'package:login_frame_task/logics/cubit/authentication_cubit.dart';
import 'package:login_frame_task/logics/cubit/profile_cubit.dart';
import 'package:login_frame_task/presentations/configs/routes/routes.dart';
import 'presentations/screens/login_screen.dart';

void main() {
  Bloc.observer = BlocCubitObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationCubit()),
        BlocProvider(
            create: (context) =>
                ProfileCubit(context.read<AuthenticationCubit>())),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Task',
          theme: ThemeData(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          routes: routes,
          home: LoginScreen(),
        ),
      ),
    );
  }
}
