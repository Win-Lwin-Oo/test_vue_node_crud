import 'package:flutter/material.dart';

class TutorialDetails extends StatefulWidget {
  const TutorialDetails(
      {Key? key,
      required this.title,
      required this.description,
      required this.published})
      : super(key: key);
  final String title;
  final String description;
  final bool published;

  @override
  _TutorialDetailsState createState() => _TutorialDetailsState();
}

class _TutorialDetailsState extends State<TutorialDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
              onPressed: () => _updateTutorial,
              child: Text('UPDATE', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(widget.description),
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Status:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(widget.published ? 'Published' : 'Pending'),
            ],
          )
        ],
      ),
    );
  }

  void _updateTutorial() {

  }
}
