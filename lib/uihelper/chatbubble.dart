import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class Chatbubble extends StatefulWidget {
  const Chatbubble({super.key});

  @override
  State<Chatbubble> createState() => _ChatbubbleState();
}

class _ChatbubbleState extends State<Chatbubble> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
        
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
              child: Container(
                child: BubbleSpecialThree(
                  text: "Hello Beta acha muhy na tum sy bat karni thi k dafa ho jao ar "
                      "do bara kabhi mujy sy bat mat karna bhosri k",
                  isSender: false,
                  tail: true,
                  color: Colors.purple,
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              child: BubbleSpecialThree(
                text: "Hello Beta",
                isSender: true,
                tail: true,
                color: Colors.purple,
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
