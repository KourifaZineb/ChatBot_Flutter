import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 400,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Card.outlined(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Image.asset('images/ChatBot_AI.png'),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: loginController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 150, 72, 0),
                        ),
                        onPressed: () {
                          String usename = loginController.text;
                          String password = passwordController.text;
                          if (usename == "user" && password == "user1") {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, "/chat");
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Theme.of(context).indicatorColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}