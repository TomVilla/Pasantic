import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/models/pasantia.dart';
import 'package:frontend/services/pasantias_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static String id = "mainPage"; 

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isSearching = false;
  late Future<List<Pasantia>> _listaPasantias;

  @override
  void initState() {
    super.initState();
    _listaPasantias = PasantiaService().getPasantias();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _isSearching? _appBarWithSearching() : _appBarWithoutSearching(),
        drawer: Drawer(
          child: Column(
            children: const [
              Text("data")
            ],
          ),
        ),
        body: _futureCardBody(),
      )
    );
  }

  Widget _futureCardBody() {
    return FutureBuilder(
      future: _listaPasantias,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData){
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              Pasantia _pasantia = snapshot.data[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      ListTile(
                        title: Text(
                          _pasantia.trabajo,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        subtitle: Text(
                          _pasantia.empresa,
                          style: const TextStyle(
                            color: Colors.black38,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          _pasantia.descripcion,
                          style: const TextStyle(fontSize: 15)
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget> [
                          Text("${_pasantia.disponibilidad} cupos disponibles"),
                          // const Spacer(),
                          TextButton(
                            child: Text(
                              "Mas informacion",
                              style: TextStyle(color: Colors.orange[300]),
                            ),
                            onPressed: (){}, 
                          )
                        ],
                      )
                    ]
                  )
                )
              );
            }
          );
        } else {
          return const Center(
            child: CircularProgressIndicator()
          );
        }
      }
    ); 
  }

  _appBarWithoutSearching () {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }
      ),
      centerTitle: true,
      title: const Text(
        "Pasantias",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          } 
        )
      ],
    );
  }

  _appBarWithSearching () {
    TextEditingController _searchController = TextEditingController();
    
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: const Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isSearching = false;
            });
          }),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: TextField(
          controller: _searchController,
          style: const  TextStyle(
            color: Colors.white,
          ),
          cursorColor: Colors.white,
          autofocus: true,
          decoration: const InputDecoration(
            focusColor: Colors.white,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
            )
          ),
        ),
      ), 
    );
  }
}