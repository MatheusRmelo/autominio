import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../injection_container.dart';
import '../presentation/camera/bloc/camera_bloc.dart';
import '../presentation/camera/camera_view.dart';
import '../presentation/cameras/cameras_view.dart';
import '../presentation/cameras/bloc/cameras_bloc.dart';

final getRouterContainer = [
  GoRoute(
    path: '/',
    name: 'home',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider<CamerasBloc>(
          create: (context) => InjectionContainer().get<CamerasBloc>(),
          child: const CamerasView(),
        ),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return FadeTransition(
            opacity: CurveTween(
              curve: Curves.easeInOutCirc,
            ).animate(animation),
            child: child,
          );
        },
      );
    },
  ),
  GoRoute(
    path: '/cameras/:id',
    name: 'get-camera',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider<CameraBloc>(
          create: (context) => InjectionContainer().get<CameraBloc>(),
          child: CameraView(
            id: state.pathParameters['id']!,
          ),
        ),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return FadeTransition(
            opacity: CurveTween(
              curve: Curves.easeInOutCirc,
            ).animate(animation),
            child: child,
          );
        },
      );
    },
  ),
];
