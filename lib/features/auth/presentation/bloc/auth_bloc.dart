import 'package:blogs_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blogs_app/core/usecase/usecase.dart';
import 'package:blogs_app/core/common/entities/user.dart';
import 'package:blogs_app/features/auth/domain/usecases/current_user.dart';
import 'package:blogs_app/features/auth/domain/usecases/user_login.dart';
import 'package:blogs_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required CurrentUser currentUser,
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required AppUserCubit appUserCubit,
  })  : _currentUser = currentUser,
        _userSignUp = userSignUp,
        _userLogin = userLogin,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignIn);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isAuthUserLoggedIn);
  }

  Future<void> _isAuthUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) {
        print("#### The current user logged in ==> ${user.name}");
        _emitAuthSuccess(user, emit);
      },
    );
  }

  Future<void> _onAuthSignIn(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(UserSignUpParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  Future<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  Future<void> _emitAuthSuccess(User user, Emitter<AuthState> emit) async {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
