import 'package:blogs_app/core/constants/constants.dart';
import 'package:blogs_app/core/error/exceptions.dart';
import 'package:blogs_app/core/error/failures.dart';
import 'package:blogs_app/core/network/connection_checker.dart';
import 'package:blogs_app/features/auth/data/models/user_model.dart';
import 'package:blogs_app/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:blogs_app/core/common/entities/user.dart';
import 'package:blogs_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImplementation(
      {required this.remoteDataSource, required this.connectionChecker});

  /// Wrapper function for login and sign -> refactoring
  Future<Either<Failures, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failures(Constants.noConnectionFound));
      }

      final userId = await fn();
      return right(userId);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failures('User not logged in'));
        }

        return right(UserModel(
          id: session.user.id,
          name: '',
          email: session.user.email ?? '',
        ));
      }

      final user = await remoteDataSource.getCurrentUserData();
      if (user != null) {
        return right(user);
      }

      return left(Failures('User not logged in!'));
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failures, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }
}
