import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> _users = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers({int page = 1}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$page&per_page=6'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<User> newUsers = (data['data'] as List).map((user) => User.fromJson(user)).toList();

      setState(() {
        _isLoading = false;
        _currentPage = page;
        _hasMore = newUsers.length == 6;
        _users.addAll(newUsers);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      ),
      body: _users.isEmpty
          ? Center(child: Text('No users found.'))
          : RefreshIndicator(
              onRefresh: () async {
                _users.clear();
                _currentPage = 1;
                await _fetchUsers();
              },
              child: ListView.builder(
                itemCount: _users.length + (_hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _users.length) {
                    _fetchUsers(page: _currentPage + 1);
                    return Center(child: CircularProgressIndicator());
                  }
                  final user = _users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                    onTap: () {
                      Navigator.pop(context, '${user.firstName} ${user.lastName}');
                    },
                  );
                },
              ),
            ),
    );
  }
}
