import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petmatch/database/db_firestore.dart';
import 'package:petmatch/models/time.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _firebaseUser; // Permite User? (nulo)
  var userIsAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();

    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.authStateChanges());

    ever(_firebaseUser, (User? user) { // Usa User? para lidar com valores nulos
      userIsAuthenticated.value = user != null;
    });
  }

  User? get user => _firebaseUser.value; // Permite User? (nulo)
  static AuthService get to => Get.find<AuthService>();

  Future<void> definirTime(Time time) async {
    final userId = _firebaseUser.value?.uid; // Permite User? (nulo)
    if (userId == null) {
      showSnack('Erro', 'Usuário não autenticado.');
      return;
    }
    try {
      FirebaseFirestore db = await DBFirestore.get();
      await db.collection('usuarios').doc(userId).set({
        'time_id': time.id,
        'time_nome': time.nome,
      });
    } catch (e) {
      showSnack('Erro ao definir time', e.toString()); // Corrige a mensagem de erro
    }
  }

  void showSnack(String titulo, String erro) {
    Get.snackbar(
      titulo,
      erro,
      backgroundColor: Colors.grey[900],
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      showSnack('Erro ao registrar!', e.toString()); // Corrige a mensagem de erro
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      showSnack('Erro no Login!', e.toString()); // Corrige a mensagem de erro
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      showSnack('Erro ao sair!', e.toString()); // Corrige a mensagem de erro
    }
  }
}