import 'package:blogs_app/core/error/failures.dart';
import 'package:blogs_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failures, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failures, User>> currentUser();
}
