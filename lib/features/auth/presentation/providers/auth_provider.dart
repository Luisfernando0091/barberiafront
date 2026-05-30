import 'package:flutter/material.dart';
import '../../../../core/storage/local_storage.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;

  UserEntity? currentUser;

  Future<bool> login({required String email, required String password}) async {
    try {
      isLoading = true;
      notifyListeners();

      final useCase = LoginUseCase(
        AuthRepositoryImpl(AuthRemoteDataSourceImpl()),
      );

      final (token, user) = await useCase(email: email, password: password);

      // Guardar usuario en memoria
      currentUser = user;
      // DEBUG
      debugPrint('========================');
      debugPrint('USER NAME: ${user.name}');
      debugPrint('USER EMAIL: ${user.email}');
      debugPrint('CURRENT USER: ${currentUser?.name}');
      debugPrint('========================');

      // Guardar token
      // Guardar token
      await LocalStorage.saveToken(token);

      debugPrint('Usuario: ${user.name}');
      debugPrint('Email: ${user.email}');
      debugPrint('Token: $token');

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }
}
