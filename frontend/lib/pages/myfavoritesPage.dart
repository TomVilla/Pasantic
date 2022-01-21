import 'package:flutter/material.dart';
import 'package:frontend/models/favorito.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/pages/descriptionPage.dart';
import 'package:frontend/services/favorito_service.dart';
import 'package:frontend/services/pasantia_service.dart';

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
            "Mis Favoritos",
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
                          TextButton(
                            child: Row(
                              children: <Widget> [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.orange[300],
                                  size: 20,
                                ),
                                Text(
                                  " Mas información",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.orange[300],
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            onPressed: (){
                              PasantiaService().getPasantiasById(_info.idpasantia).then((value) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionPage(info: value)));
                              });
                            }, 
                          ),
                          TextButton(
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.delete_forever,
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
                              FavoritoService().eliminarFavorito(_info.idpasantia).then((value) {
                                setState(() {
                                  _favoritos = FavoritoService().getFavoritos();
                                });
                                _toast("La Pasantia se ha eliminado de Favoritos");
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

  Future<bool?> _toast(String texto, {String? gradiente="linear-gradient(to right, #00b09b, #96c93d)"}) {
    return Fluttertoast.showToast(
      msg: texto,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      textColor: Colors.white,
      webBgColor: gradiente,
      fontSize: 18.0
    );
  }
}