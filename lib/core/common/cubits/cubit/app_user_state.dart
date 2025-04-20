part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  /// Core cannot depend on features but features can depend on core
  /// Hence we move the user entity from domain to core so that
  /// all the features that have user state can access the user model
  final User user;

  AppUserLoggedIn({required this.user});

}
