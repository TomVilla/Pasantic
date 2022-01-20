import 'package:flutter/material.dart';
import 'package:frontend/models/pasantia.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key? key}) : super(key: key);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    // Pasantia  _info = (ModalRoute.of(context)?.settings.arguments as Pasantia);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            children: const [
              ListTile(
                title: Text(
                  "Mantenimiento de Software",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  "espol",
                  style: TextStyle(
                    color: Colors.black38,
                    fontStyle: FontStyle.italic
                  ),
                ),
                contentPadding: EdgeInsets.zero,
              ),
              Text("Mantenimiento de Software"),
              Text("09"),
              Text("espol@com"),
              Text("ninguno"),
              Text("_info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion _info.descripcion "),
              Text("gye"),
              Text("32 cupos disponibles"),
            ],
          ),
        )
      )
    );
  }
}