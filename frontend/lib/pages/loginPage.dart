import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomPaint(
          painter: _BackgroundPaint(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: FlutterLogo(
                    size: 150,
                    style: FlutterLogoStyle.stacked,
                  ),
                ),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black38
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Column(
                    children: [
                      Text(
                        "Bienvenidos!!!",
                        style: TextStyle(
                          color: Colors.orange[300],
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                        ),
                      ),
                      _loginForm(context),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  <Widget> [
                          const Text("¿Aun no tienes cuenta?"),
                          TextButton(
                            child: const Text("Registrate Ahora"),
                            onPressed: () {
                              Navigator.of(context).pushNamed("register");
                            }, 
                          )
                        ],
                      )
                    ],
                  )
                ),
              ],
            )
          )
        )
      )
    );
  }

  Widget _loginForm(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();

    return Form(
      child: Column(
        children: <Widget> [
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle( color: Colors.black26 ),
            decoration: const InputDecoration(
              hintText: 'Ingrese el correo electronico',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontSize: 12
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2)
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            controller: _password,
            keyboardType: TextInputType.text,
            style: const TextStyle( color: Colors.black26 ),
            decoration: const InputDecoration(
              hintText: 'Ingrese la contraseña',
              hintStyle: TextStyle(
                color: Colors.black26,
                fontSize: 12
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2)
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  child: const Text('Iniciar Sesion'),
                  textColor: Colors.white,
                  color: Colors.orange[300],
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  onPressed: () {
                    if(_email.text.isNotEmpty && _password.text.isNotEmpty) {
                      Navigator.of(context).pushNamed("/");
                    }
                  },
                ),
              )
            ],
          )
        ]
      ),
    );
  }
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