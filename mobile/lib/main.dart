import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatbotScreen(),
    );
  }
}

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';

  Future<void> _sendMessage(String message) async {
    final String apiUrl = 'http://localhost:8080/chat'; // Replace with your API endpoint
    final response = await http.get(Uri.parse('$apiUrl/$message'));

    if (response.statusCode == 200) {
      setState(() {
        _response = json.decode(response.body)['response']; // Adjust based on your API response format
      });
    } else {
      setState(() {
        _response = 'Failed to get response from API';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your message',
              ),
              onSubmitted: (String value) {
                _sendMessage(value);
                _controller.clear();
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendMessage(_controller.text);
                _controller.clear();
              },
              child: Text('Send'),
            ),
            SizedBox(height: 20),
            Text(
              'Response:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(_response),
          ],
        ),
      ),
    );
  }
}