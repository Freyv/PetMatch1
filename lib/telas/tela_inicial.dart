import 'package:flutter/material.dart';

class TelaInicialWidget extends StatefulWidget {
  const TelaInicialWidget({super.key});

  @override
  State<TelaInicialWidget> createState() => _TelaInicialWidgetState();
}

class _TelaInicialWidgetState extends State<TelaInicialWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Ajuste a cor do fundo aqui
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: false,
              backgroundColor: const Color(0xFFF4A905),
              automaticallyImplyLeading: false,
              title: Align(
                alignment: const AlignmentDirectional(-1, 1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'images/PetMatchLogo4.png',
                    width: 112,
                    height: 38,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 23, 0),
                        child: Icon(
                          Icons.add_box,
                          size: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 23, 0),
                        child: Icon(
                          Icons.notifications,
                          size: 24,
                        ),
                      ),
                      Icon(
                        Icons.chat_bubble_rounded,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 2,
            )
          ],
          body: SafeArea(
            top: false,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildPost(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPost(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
            child: SizedBox(
              width: double.infinity,
              height: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'images/camarelo2.jpeg',
                                  ),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Text(
                                'Caramelo',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_control,
                        color: Colors.black,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.zero,
              child: Image.asset(
                'images/putaque_pariu.jpg',
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                          size: 24,
                        ),
                        SizedBox(width: 14),
                        Icon(
                          Icons.chat_bubble,
                          color: Colors.black,
                          size: 24,
                        ),
                        SizedBox(width: 14),
                        Icon(
                          Icons.send,
                          color: Colors.black,
                          size: 24,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.bookmark_border,
                      color: Colors.black,
                      size: 24,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Text(
                        '2.190 Curtidas',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Row(
                    children: [
                      Text(
                        'Caramelo ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Eu fui eu tava',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/user.webp'),
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Text(
                          'Adicione um comentário..',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                      '8 horas atrás',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
