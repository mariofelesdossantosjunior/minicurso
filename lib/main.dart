import 'package:flutter/material.dart';
import 'package:mini_curso_flutter/home.dart';
import 'package:mini_curso_flutter/shared/service/service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Curso Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Mini Curso"),
        ),
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _nameController = new TextEditingController();
  ServiceHasura _service = new ServiceHasura();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
                autofocus: true,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                )),
            RaisedButton(
              onPressed: () async {
                var name = _nameController.text;
                if (name.isNotEmpty) {
                  await _service.login(name).then((user) {
                    Navigator.pop(context);
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage(user: user,)));
                  });
                } else {
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text("Digite seu nome!"),
                  ));
                }
              },
              child: Text(
                "Entrar",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
