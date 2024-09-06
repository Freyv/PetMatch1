import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petmatch/telas/nav_bar_page.dart';

class TelaCadastroWidget extends StatefulWidget {
  const TelaCadastroWidget({super.key});

  @override
  State<TelaCadastroWidget> createState() => _CadastroWidgetState();
}

class _CadastroWidgetState extends State<TelaCadastroWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Controllers and FocusNodes
  final TextEditingController emailTextController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController senhaTextController = TextEditingController();
  final FocusNode senhaFocusNode = FocusNode();
  final TextEditingController senhaConfirmarTextController = TextEditingController();
  final FocusNode senhaConfirmarFocusNode = FocusNode();

  bool senhaVisibility = false;
  bool senhaConfirmarVisibility = false;

  @override
  void initState() {
    super.initState();
    senhaVisibility = false;
    senhaConfirmarVisibility = false;
  }

  @override
  void dispose() {
    emailTextController.dispose();
    emailFocusNode.dispose();
    senhaTextController.dispose();
    senhaFocusNode.dispose();
    senhaConfirmarTextController.dispose();
    senhaConfirmarFocusNode.dispose();
    super.dispose();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Insira um endereço de email';
    }
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegExp.hasMatch(value)) {
      return 'Insira um endereço de email válido';
    }
    return null;
  }

  String? senhaValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
      return 'A senha deve conter pelo menos uma letra minúscula';
    }
    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      return 'A senha deve conter pelo menos uma letra maiúscula';
    }
    if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
      return 'A senha deve conter pelo menos um número';
    }
    if (!RegExp(r'^(?=.*[!@#\$%^&*])').hasMatch(value)) {
      return 'A senha deve conter pelo menos um caractere especial';
    }
    return null;
  }

  String? confirmarSenhaValidator(String? value, String senha) {
    if (value == null || value.isEmpty) {
      return 'Confirme a senha';
    }
    if (value != senha) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  Future<void> _createAccount() async {
    String? emailError = emailValidator(emailTextController.text);
    String? senhaError = senhaValidator(senhaTextController.text);
    String? confirmarSenhaError = confirmarSenhaValidator(
      senhaConfirmarTextController.text,
      senhaTextController.text,
    );

    if (emailError != null || senhaError != null || confirmarSenhaError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(emailError ?? senhaError ?? confirmarSenhaError ?? 'Erro desconhecido'),
        ),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text.trim(),
        password: senhaTextController.text.trim(),
      );

      if (userCredential.user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const NavBarPage(initialPage: 'tela_inicial'),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      print('Failed to create account: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create account: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        resizeToAvoidBottomInset: true, // Permitir rolagem quando o teclado aparece
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 320,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/PetMatchLogo2.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 310),
                    child: SizedBox(
                      height: 80,
                      child: Image.asset(
                        'images/Divisor.png',
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 380, 30, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Cadastre-se',
                            style: GoogleFonts.lexendDeca(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 22),
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 500,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 24, bottom: 12),
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surface,
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: TextFormField(
                                            controller: emailTextController,
                                            focusNode: emailFocusNode,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                              labelStyle: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            validator: emailValidator,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surface,
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: TextFormField(
                                            controller: senhaTextController,
                                            focusNode: senhaFocusNode,
                                            obscureText: !senhaVisibility,
                                            decoration: InputDecoration(
                                              labelText: 'Senha',
                                              labelStyle: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              border: InputBorder.none,
                                              suffixIcon: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    senhaVisibility = !senhaVisibility;
                                                  });
                                                },
                                                child: Icon(
                                                  senhaVisibility
                                                      ? Icons.visibility_outlined
                                                      : Icons.visibility_off_outlined,
                                                  color: Colors.grey,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                            validator: senhaValidator,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surface,
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: TextFormField(
                                            controller: senhaConfirmarTextController,
                                            focusNode: senhaConfirmarFocusNode,
                                            obscureText: !senhaConfirmarVisibility,
                                            decoration: InputDecoration(
                                              labelText: 'Confirmar senha',
                                              labelStyle: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              border: InputBorder.none,
                                              suffixIcon: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    senhaConfirmarVisibility = !senhaConfirmarVisibility;
                                                  });
                                                },
                                                child: Icon(
                                                  senhaConfirmarVisibility
                                                      ? Icons.visibility_outlined
                                                      : Icons.visibility_off_outlined,
                                                  color: Colors.grey,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                            validator: (value) => confirmarSenhaValidator(
                                              value,
                                              senhaTextController.text,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: _createAccount,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFF4A905),
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        side: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      child: const SizedBox(
                                        width: double.infinity,
                                        height: 55,
                                        child: Center(
                                          child: Text(
                                            'Criar Conta',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 14),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Já tem uma conta?',
                                            style: GoogleFonts.poppins(fontSize: 14),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Entrar'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
