import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static String id = "mainPage"; 

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isSearching = false;

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
        body: Column(
          children: const [
            Text("data")
          ]
        )
      )
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