import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  List<String> messages = [];
  bool requestedDescription =
      false; // Added variable to track if description has been requested

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Image.asset("assets/images/SafeConnect 1.png"),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // Buttons for reporting an issue or giving queries/feedback
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _handleButtonPressed("Report an Issue"),
                child: const Text("Report an Issue"),
              ),
              ElevatedButton(
                onPressed: () => _handleButtonPressed("Queries/Feedback"),
                child: const Text("Queries/Feedback"),
              ),
            ],
          ),
          const Divider(height: 1.0),
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (_, int index) => ListTile(
                title: Text(messages[index]),
              ),
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: "Send a message",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleButtonPressed(String buttonText) {
    // Respond based on the button pressed
    if (buttonText == "Report an Issue") {
      _addResponse("You pressed: Report an Issue");
      // You can add additional logic for handling issue reporting
    } else if (buttonText == "Queries/Feedback") {
      _addResponse("You pressed: Queries/Feedback");
      // You can add additional logic for handling queries/feedback
    }
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    // Add the user's message to the chat
    _addResponse("You: $text");

    // Respond with a message or show the popup if all questions are answered
    if (!requestedDescription) {
      requestedDescription = true;
      // Ask for a detailed description of the item
      _addResponse(
          "Chat Bot: Please provide a detailed description of the item.");
    } else {
      _respondToMessage(text);
    }
  }

  void _respondToMessage(String text) {
    // Respond with a message based on the user's input
    // Here, you could parse the user's input and provide appropriate responses
    // For simplicity, we'll just acknowledge the receipt of the message
    _addResponse("Chat Bot: Thank you for your response!");

    // Show the "Thank you for your patience" popup after getting all the answers
    _showPopupMessage();
  }

  void _showPopupMessage() {
    // Show a popup message after getting all the answers
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Chat Bot"),
          content:
              const Text("Thank you for your patience, we've forwarded your query"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _addResponse(String response) {
    setState(() {
      messages.insert(0, response);
    });
  }
}
