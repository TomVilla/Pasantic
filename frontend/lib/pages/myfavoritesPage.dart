import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/favorito.dart';
import 'package:frontend/services/favorito_service.dart';

class MyFavoritesPage extends StatefulWidget {
  const MyFavoritesPage({Key? key}) : super(key: key);

  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  late Future<List<Favorito>> _favoritos;

  @override
  void initState() {
    super.initState();
    _favoritos = FavoritoService().getFavoritos();
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
      future: _favoritos,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Favorito _info = snapshot.data[index];

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
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
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
                            "${_info.disponibilidad} cupos disponibles",
                            style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 15
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
                                  " Eliminar de Favoritos",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            onPressed: (){
                              FavoritoService().eliminarFavorito(_info.idfavorito).then((value) {
                                setState(() {
                                  _favoritos = FavoritoService().getFavoritos();
                                });
                                Fluttertoast.showToast(
                                  msg: "La Pasantia se ha eliminado de Favoritos",
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