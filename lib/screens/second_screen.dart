import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String? _userName;

  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text(
              _userName ?? 'John Doe',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Center(
              child: Text(
                'Selected User Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(), 
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final selectedUserName = await Navigator.pushNamed(context, '/third');
                  if (selectedUserName != null) {
                    setState(() {
                      _userName = selectedUserName as String?;
                    });
                  }
                },
                child: Text('Choose a User'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  backgroundColor: Color(0xFF0083B0),
                  foregroundColor: Colors.white, // Set text color to white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
