import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/sidebar/sidebar.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  final List<SidebarItemModel> _features = [
    SidebarItemModel(
        icon: Icons.menu_book, name: 'Categorias', route: '/categories'),
  ];
  int _active = 0;

  int get active => _active;
  List<SidebarItemModel> get features => _features;

  void navigate(BuildContext context, int index) {
    Navigator.pushReplacementNamed(context, _features[index].route);
    _active = index;
    emit(NavigationChange(active: index));
  }
}
