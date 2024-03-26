import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dog Images App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DogImagesPage(),
    );
  }
}
class DogImagesPage extends StatefulWidget {
  @override
  _DogImagesPageState createState() => _DogImagesPageState();
}

class _DogImagesPageState extends State<DogImagesPage> {
  List<String> _dogImageUrls = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDogImages();
  }
