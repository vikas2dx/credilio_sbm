import 'dart:convert';

import 'package:crediliosbm/crediliosbm.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _crediliosbmPlugin = Crediliosbm();
  final crediloToken = "Your Token";
  final generateTokenUrl = 'Your url';

  var params = {
    'email': 'vikas2dx@gmail.com',
    'module_type': 'LANDING',
    'terms_and_condition': true
  };

  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getToken() async {
    try {
      // Make the POST request with token in headers
      Response response = await _dio.post(
        generateTokenUrl,
        data: jsonEncode(params),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer $crediloToken', // Replace YourTokenHere with actual token
          },
        ),
      );

      if (response.statusCode == 200) {
        // Handle successful response here
        var token =
            response.data['token']; // Assuming token is returned in response
        debugPrint('Token: $token');

        // Now you can use the token with _crediliosbmPlugin.openLibrary()
        await _crediliosbmPlugin.openLibrary(
            token: token, email: 'vikas2dx@gmail.com');
      } else {
        throw Exception('Failed to get token');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _openLibrary() async {
    try {
      await _crediliosbmPlugin.openLibrary(
          token: 'Your Token', email: 'Your email');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: GestureDetector(
        onTap: _getToken,
        child: const Center(
          child: Text('Click Here'),
        ),
      ),
    );
  }
}
