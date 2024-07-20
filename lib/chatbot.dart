
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<dynamic> data = [
    {'message': 'Hello', 'type': 'user'},
    {'message': 'Hi there! How can I assist you today?', 'type': 'assistant'},
    {'message': 'Give me information about you.', 'type': 'user'},
    {'message': 'Sure! I am ChatGPT, an AI language model created by OpenAI.', 'type': 'assistant'},
  ];

  TextEditingController queryController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatBot page"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: data.length,
              itemBuilder: (context, index) {
                bool isUser = data[index]['type'] == 'user';
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Row(
                          children: [
                            SizedBox(
                              width: isUser ? 100 : 0,
                            ),
                            Expanded(
                              child: Card(
                                child: Container(
                                  child: Text(
                                    data[index]['message'],
                                  ),
                                  padding: EdgeInsets.all(10),
                                  color: (isUser)
                                      ? Color.fromARGB(173, 7, 23, 255)
                                      : Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: isUser ? 0 : 100,
                            )
                          ],
                        ),
                        leading: (!isUser) ? Icon(Icons.support_agent) : null,
                        trailing: (isUser) ? Icon(Icons.person_2) : null,
                      ),
                    ),
                    Divider(
                      height: 1,
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: queryController,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(Icons.visibility),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String query = queryController.text;
                    var url = Uri.https("api.openai.com", "/v1/chat/completions");
                    Map<String, String> userHeaders = {
                      "Content-type": "application/json",
                      "Authorization": "Bearer"
                    };
                    http
                        .post(url,
                            headers: userHeaders,
                            body: json.encode({
                              "model": "gpt-3.5",
                              "messages": [
                                {"role": "user", "content": query}
                              ],
                              "temperature": 0.7
                            }))
                        .then((resp) {
                      var result = json.decode(resp.body);
                      setState(() {
                        data.add({
                          "message": result['choices'][0]['message']['content'],
                          "type": "assistant"
                        });
                        scrollController.jumpTo(
                            scrollController.position.maxScrollExtent + 60);
                      });
                    }, onError: (err) {
                      print("-------------------- ERROR------------");
                      print(err);
                    });
                    setState(() {
                      data.add({'message': query, 'type': 'user'});
                      scrollController.jumpTo(
                          scrollController.position.maxScrollExtent + 60);
                    });
                  },
                  icon: Icon(Icons.send),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
