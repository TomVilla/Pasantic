import 'package:flutter/material.dart';
import 'package:frontend/models/estudiante.dart';
import 'package:frontend/pages/loginPage.dart';
import 'package:frontend/services/estudiante_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static String id = "registerPage";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomPaint(
          painter: _BackgroundPaint(),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black38
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              alignment: Alignment.topLeft,
                              icon: const Icon(Icons.arrow_back),
                              onPressed: (){
                                Navigator.pop(context);
                              }, 
                            ),
                          ],
                        ),
                        _formRegisterPage(context),
                      ]
                    )
                  ),
                )
              ],
            ) 
          )
        )
      ),
    );
  }
}

Widget _formRegisterPage(BuildContext context) {
  TextEditingController _nombre = TextEditingController();
  TextEditingController _celular = TextEditingController();
  TextEditingController _universidad = TextEditingController();
  TextEditingController _carrera = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();


  return Padding(
    padding: const EdgeInsets.all(25),
    child: Form(
      child: Column(
        children: <Widget> [
          Text(
            "Llena los campos para continuar!!!",
            style: TextStyle(
              color: Colors.orange[300],
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _nombre,
            keyboardType: TextInputType.text,
            style: const TextStyle( color: Colors.black26 ),
            decoration: const InputDecoration(
              hintText: 'Ingrese su nombre y apellido',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontSize: 12
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2)
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _celular,
            keyboardType: TextInputType.phone,
            style: const TextStyle( color: Colors.black26 ),
            decoration: const InputDecoration(
              hintText: 'Ingrese su numero de telefono',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontSize: 12
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2)
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _universidad,
            keyboardType: TextInputType.text,
            style: const TextStyle( color: Colors.black26 ),
            decoration: const InputDecoration(
              hintText: 'Ingrese el nombre de su Universidad',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontSize: 12
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2)
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _carrera,
            keyboardType: TextInputType.text,
            style: const TextStyle( color: Colors.black26 ),
            decoration: const InputDecoration(
              hintText: 'Ingrese el nombre de su carrera',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontSize: 12
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2)
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle( color: Colors.black26 ),
            decoration: const InputDecoration(
              hintText: 'Ingrese su email',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontSize: 12
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2)
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _password,
            obscureText: true,
            keyboardType: TextInputType.text,
            style: const TextStyle( color: Colors.black26 ),
            decoration: const InputDecoration(
              hintText: 'Ingrese su contraseña',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontSize: 12
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2)
            ),
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  child: const Text('Registrate'),
                  textColor: Colors.white,
                  color: Colors.orange[300],
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  onPressed: () {
                    if(_nombre.text.isNotEmpty && _celular.text.isNotEmpty && _universidad.text.isNotEmpty && _carrera.text.isNotEmpty && _email.text.isNotEmpty && _password.text.isNotEmpty){
                      EstudianteService().newEstudiante(
                        Estudiante(_nombre.text, _celular.text, _universidad.text, _carrera.text, _email.text, _password.text)
                      ).then((value) {
                        print(value);
                        Navigator.of(context).pushNamed(LoginPage.id);
                      });
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    )
  );
}

class _BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.cyan
      ..strokeWidth = 15;

    var path = Path();

    //Primer curva
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height*0.1);
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.08,
      size.width * 0.5, size.height * 0.2
    );
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.33,
      0, size.height * 0.35
    );
    path.lineTo(0, 0);

    //Segunda Curva
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height*0.4);
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.38, 
      size.width * 0.5, size.height * 0.5
    );
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.63, 
      0, size.height * 0.65
    );
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}