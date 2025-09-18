import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tm8_game_admin/app/app_bloc/app_bloc.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/login/presentation/logic/login_cubit/login_cubit.dart';
import 'package:tm8_game_admin/login/presentation/view/login_screen.dart';

class EntryPointScreen extends StatefulWidget {
  const EntryPointScreen({super.key});

  @override
  State<EntryPointScreen> createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AppBloc>()..add(const AppEvent.checkStatus()),
        ),
        BlocProvider(
          create: (context) => sl<LoginCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              state.whenOrNull(
                authenticated: () {
                  context.beamToNamed(
                    home,
                  );
                },
                unauthenticated: () {
                  context.beamToNamed(login);
                },
              );
            },
            child: const LoginScreen(),
          );
        },
      ),
    );
  }
}
