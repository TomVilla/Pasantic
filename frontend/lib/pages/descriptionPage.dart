import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:frontend/models/pasantia.dart';
import 'package:frontend/services/favorito_service.dart';
import 'package:frontend/services/postulacion_service.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key? key}) : super(key: key);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  late bool _isEnableFavoriteButton = true;
  late bool _isEnablePostulacionButton = true;

  @override
  Widget build(BuildContext context) {
    Pasantia  _info = (ModalRoute.of(context)?.settings.arguments as Pasantia);
    FavoritoService().verificarFavorito(_info.idpasantia).then((value) {
      setState(() {_isEnableFavoriteButton = value;});
    });
    PostulacionService().verificarPostulacion(_info.idpasantia).then((value) {
      setState(() {_isEnablePostulacionButton = value;});
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed("/");
            },
          ),
          centerTitle: true,
          title: const Text(
            "Detalle de la Pasantía",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget> [
              _widgetTitulo(_info.idpasantia,_info.trabajo, _info.empresa),
              const SizedBox(height: 10),
              _widgetSubTitulo(
                "Informacion de Contacto", 18,
                subwidget: Column(
                  children: [
                    _infoAdicional("Correo Electronico: ", _info.email),
                    _infoAdicional("Dirección: ", _info.direccion),
                    _infoAdicional("Telefono: ", _info.telefono),
                    _infoAdicional("Cupos: ", "${_info.disponibilidad}"),
                  ],
                ),
              ),
              _widgetSubTitulo("Requisitos", 18, subtitulo: _info.requisitos, size2: 15),
              _widgetSubTitulo("Descripcion", 18, subtitulo: _info.descripcion, size2: 15),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  _botonFavoritos(_info.idpasantia),
                  _botonPostulacion(_info.idpasantia)
                ],
              )
            ],
          ),
        )
      )
    );
  }

  Widget _widgetTitulo(int i, String titulo, String subtitulo) {
    return ListTile(
      title: Text(
        titulo,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Text(
        subtitulo,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black38,
          fontStyle: FontStyle.italic
        ),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _widgetSubTitulo(String titulo, double size1, {String subtitulo="null", double? size2=15, Widget? subwidget}) {
    if (subwidget==null) {
      return ListTile(
        title: Text(
          titulo,
          style: TextStyle(
            fontSize: size1,
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text(
          subtitulo,
          style: TextStyle(
            fontSize: size2,
            color: Colors.black,
          ),
          textAlign: TextAlign.justify,
        ),
        contentPadding: EdgeInsets.zero,
      ); 
    } else {
      return ListTile(
        title: Text(
          titulo,
          style: TextStyle(
            fontSize: size1,
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: subwidget,
        contentPadding: EdgeInsets.zero,
      ); 
    }
  }

  Widget _infoAdicional(String campo, String info) {
    return Row(
      children: <Widget> [
        Text(
          campo,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        Text(
          info,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black
          )
        ),
      ],
    );
  }
  
  Widget _botonPostulacion(int id) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        disabledColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        color: _isEnablePostulacionButton? Colors.orange[300]: Colors.teal[300],
        child: Row(
          children: <Widget> [
            Icon(
              _isEnablePostulacionButton? Icons.post_add_outlined: Icons.delete_forever, 
              size: 18, 
              color: Colors.white
            ),
            Text(
              _isEnablePostulacionButton? " Postularme": "Cancelar Postulacion",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15
              ),
            )
          ],
        ),
        onPressed: _isEnablePostulacionButton?(){
          PostulacionService().postular(id).then((value) {
            if (value == 200) {
              setState(() {_isEnableFavoriteButton = false;});
              _toast("La Postulacion ha sido exitosa");
            }
          });
        }: (){
          PostulacionService().eliminarPostulacion(id).then((value){
            if (value == 200) {
              setState(() {_isEnableFavoriteButton = true;});
              _toast("Ya se ha postulado para esta pasantia", gradiente: "linear-gradient(to right, #FF0000, #F69191)");
            }
          });
        }, 
      ),
    );
  }

  Widget _botonFavoritos(int id) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        disabledColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        color: _isEnableFavoriteButton? Colors.cyan[300]: Colors.brown[300],
        child: Row(
          children: <Widget> [
            Icon(
              _isEnableFavoriteButton? Icons.star_outline: Icons.close, 
              size: 18, 
              color: Colors.white
            ),
            Text(
              _isEnableFavoriteButton? " Añadir a Favoritos": " Eliminar de Favoritos",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15
              ),
            )
          ],
        ),
        onPressed: _isEnableFavoriteButton? () {
          FavoritoService().addFavorito(id).then((value) {
            if(value == 200){
              setState(() {_isEnableFavoriteButton = false;});
              _toast("Se ha añadido la pasantia a favoritos");
            }
          });
        }: (){
          FavoritoService().eliminarFavorito(id).then((value) {
            if(value == 200){
              setState(() {_isEnableFavoriteButton = true;});
              _toast("La pasantia ya fue agregada a favoritos", gradiente: "linear-gradient(to right, #FF0000, #F69191)");
            }
          });
        }, 
      ),
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