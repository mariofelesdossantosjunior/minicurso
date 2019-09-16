import 'package:flutter/material.dart';
import 'package:mini_curso_flutter/shared/model/user_model.dart';

import 'shared/model/message_model.dart';
import 'shared/service/service.dart';

class HomePage extends StatefulWidget {
  UserModel user;

  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _messageController = new TextEditingController();
  ServiceHasura _service = new ServiceHasura();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Chat"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () {},
          )
        ],
      ),
      body: StreamBuilder<List<MessageModel>>(
        stream: _service.getMessages(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  reverse: false,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].user.name),
                      subtitle: Text(snapshot.data[index].message),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        var id_user = widget.user.id;
                        var message = _messageController.text;

                        if (message.isNotEmpty) {
                          await _service
                              .sendMessage(id_user, message)
                              .then((user) {
                            /* Scaffold.of(context).showSnackBar(new SnackBar(
                              content:
                                  new Text("Mensagem enviado com sucesso!"),
                            )); */
                            _messageController.clear();
                          });
                        } else {
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text("Digite sua mensagem!"),
                          ));
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
