import 'package:flutter/material.dart';

import 'package:frontend/models/estudiante.dart';
import 'package:frontend/services/estudiante_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Estudiante> _infoEstudiante;

  @override
  void initState() {
    super.initState();
    _infoEstudiante = EstudianteService().infoEstudiante(2);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: _futureInfoBody()
      )
    );
  }

  Widget _futureInfoBody() {
    return FutureBuilder(
      future: _infoEstudiante,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData){
          Estudiante _info = snapshot.data;
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.cyan,
                          Colors.cyanAccent,
                          Colors.teal
                        ]
                      )
                    ),
                  ),
                  Positioned(
                    top: 145,
                    child: Column(
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 85,
                        ),
                      ]
                    )
                  ),
                  Positioned(
                    top: 150,
                    child: Column(
                      children: <Widget> [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage('https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/portrait-of-smiling-mature-man-on-the-beach-royalty-free-image-1615474726.?crop=0.669xw:1.00xh;0.199xw,0&resize=640:*'),
                          radius: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            _info.nombre,
                            style: TextStyle(
                              color: Colors.orange[300],
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150, left: 40, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      "Universidad: ${_info.universidad}",
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 20
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical:10)),
                    Text(
                      "Carrera: ${_info.carrera}",
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 20
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical:10)),
                    Text(
                      "Correo: ${_info.correo}",
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 20
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical:10)),
                    Text(
                      "Celular: ${_info.celular}",
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
              )
            ]
          );
        } else {
          return const Center(
            child: CircularProgressIndicator()
          );
        }
      }
    );
  }
}