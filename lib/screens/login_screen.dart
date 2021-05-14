import "package:flutter/material.dart";

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            child: Image.asset("assets/images/logo.jpeg"),
          ),
          Container(
            child: Column(
              children: [
                Text("LOGIN"),
                Row(
                  children: [
                    Icon(
                      Icons.alternate_email
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: "DTU ROLL NUMBER"),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.lock,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: "PASSWORD"),
                      ),
                    )
                  ],
                ),
                Text("FORGOT PASSWORD?"),
                ElevatedButton(onPressed: () {}, child: Text("LOGIN"))
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "Don't have an account?",
                ),
                Text(
                  "REGISTER.",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
