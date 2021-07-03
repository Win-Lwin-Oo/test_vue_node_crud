import 'package:flutter/material.dart';

class SearchTutorialPage extends StatefulWidget {
  const SearchTutorialPage({Key? key}) : super(key: key);

  @override
  _SearchTutorialPageState createState() => _SearchTutorialPageState();
}

class _SearchTutorialPageState extends State<SearchTutorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Center(

      ),
    );
  }
}
