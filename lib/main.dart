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
  Future<void> _fetchDogImages() async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final String data = json.decode(response.body)['message'];
      setState(() {
        _dogImageUrls.add(data);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load dog images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Dog Images'),
    ),
    body: _isLoading
    ? Center(
    child: CircularProgressIndicator(),
    )
        : ListView.builder(
    itemCount: _dogImageUrls.length,
    itemBuilder: (context, index) {
    return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
    width: double.infinity,
    height: 200,
    child: Image.network(
    _dogImageUrls[index],
    fit: BoxFit.cover,
    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
    return child;
    } else {
    return Center(child: CircularProgressIndicator());
    }
    },
    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
    return Icon(Icons.error);
    },
    ),
    ),
    );
    },
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchDogImages,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
