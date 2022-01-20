import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/postulacion.dart';
import 'package:frontend/services/postulacion_service.dart';

class MyApplicationsPage extends StatefulWidget {
  const MyApplicationsPage({Key? key}) : super(key: key);

  @override
  _MyApplicationsPageState createState() => _MyApplicationsPageState();
}

class _MyApplicationsPageState extends State<MyApplicationsPage> {
  late Future<List<Postulacion>> _postulaciones;

  @override
  void initState() {
    super.initState();
    _postulaciones = PostulacionService().getPostulaciones();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: const Text(
            "Mis Postulaciones",
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        body: _futureCardBody(),
      )
    );
  }

  Widget _futureCardBody() {
    return FutureBuilder(
      future: _postulaciones,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Postulacion _info = snapshot.data[index];
              Color? _colorEstado = Colors.orange[300];

              if(_info.estado == "Postulado") {
                _colorEstado = Colors.orange[300];
              } else if (_info.estado == "rechazado"){
                _colorEstado = Colors.red;
              } else {
                _colorEstado = Colors.green;
              }

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      ListTile(
                        title: Text(
                          _info.trabajo,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        subtitle: Text(
                          _info.empresa,
                          style: const TextStyle(
                            color: Colors.black38,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                        contentPadding: EdgeInsets.zero
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          _info.descripcion,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 12)
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget> [
                          Text(
                            _info.estado,
                            style: TextStyle(
                              color: _colorEstado,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          TextButton(
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                Text(
                                  " Eliminar Postulacion",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            onPressed: (){
                              PostulacionService().eliminarPostulacion(_info.idpostulacion).then((value) {
                                setState(() {
                                  _postulaciones = PostulacionService().getPostulaciones();
                                });
                                Fluttertoast.showToast(
                                  msg: "La Postulacion se ha eliminado con exito",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  textColor: Colors.white,
                                  fontSize: 18.0
                                );
                              });
                            }, 
                          )
                        ],
                      )
                    ]
                  ),
                )
              );
            },
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