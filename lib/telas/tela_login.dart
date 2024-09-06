import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petmatch/telas/nav_bar_page.dart';
import 'package:petmatch/telas/tela_cadastro.dart';

class TelaLoginWidget extends StatefulWidget {
  const TelaLoginWidget({super.key});

  @override
  State<TelaLoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<TelaLoginWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailTextController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController senhaTextController = TextEditingController();
  final FocusNode senhaFocusNode = FocusNode();
  bool senhaVisibility = false;

  @override
  void initState() {
    super.initState();
    senhaVisibility = false;
  }

  @override
  void dispose() {
    emailTextController.dispose();
    emailFocusNode.dispose();
    senhaTextController.dispose();
    senhaFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: keyboardSpace),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 320,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/PetMatchLogo2.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 310),
                        child: Container(
                          height: 80,
                          decoration: const BoxDecoration(),
                          child: Image.asset(
                            'images/Divisor.png',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 380, 30, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Login',
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
                                      mainAxisSize: MainAxisSize.max,
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
                                                keyboardType: TextInputType.emailAddress,
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
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // Adicione a navegação para a página de redefinição de senha aqui.
                                                },
                                                child: Text(
                                                  'Esqueci minha senha',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              // Lógica de login
                                              try {
                                                UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                                  email: emailTextController.text.trim(),
                                                  password: senhaTextController.text.trim(),
                                                );

                                                if (userCredential.user != null) {
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const NavBarPage(initialPage: 'tela_inicial'),
                                                    ),
                                                    (r) => false,
                                                  );
                                                }
                                              } catch (e) {
                                                print('Erro ao fazer login: $e');
                                                // Handle sign-in error
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Erro ao fazer login: $e'),
                                                  ),
                                                );
                                              }
                                            },
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
                                                  'Entrar',
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 14),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Não tem uma conta?',
                                                style: GoogleFonts.poppins(fontSize: 14),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const TelaCadastroWidget(),
                                                    ),
                                                  );
                                                },
                                                child: const Text('Cadastrar'),
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
        ),
      ),
    );
  }
}
