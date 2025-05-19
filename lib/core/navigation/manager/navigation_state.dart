part of 'navigation_cubit.dart';

sealed class NavigationState {}

final class NavigationInitial extends NavigationState {}

final class NavigationChange extends NavigationState {
  int active;
  NavigationChange({required this.active});
}
