import 'package:flutter/material.dart';
import 'package:petmatch/services/auth_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:petmatch/telas/tela_inicial.dart';
import 'package:petmatch/telas/tela_login.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => AuthService.to.userIsAuthenticated.value
        ? const TelaInicialWidget()
        : const TelaLoginWidget());
  }
}