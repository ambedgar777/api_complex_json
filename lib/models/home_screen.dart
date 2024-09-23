import 'dart:convert';

import 'package:api_complex_json/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //creating list for the user data
  List<UserModel> userList = [];

  //future method to get the data from API
  Future<List<UserModel>> getUserModel() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      //using for loop to add the data in the list
      //fetching the data using the UserModel class
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text('API COMPLEX JSON'),
        backgroundColor: Colors.purple.shade200,
      ),
      body: FutureBuilder(
        future: getUserModel(),
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Text('LOADING DATA');
          } else {
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(12),
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.purple.shade200,
                  ),
                  child: Column(
                    children: [
                      ReUsableRow(
                        title: 'ID: ',
                        value: snapshot.data![index].id.toString(),
                      ),
                      ReUsableRow(
                        title: 'Name: ',
                        value: snapshot.data![index].name.toString(),
                      ),
                      ReUsableRow(
                        title: 'Username: ',
                        value: snapshot.data![index].username.toString(),
                      ),
                      ReUsableRow(
                        title: 'Address',
                        value:
                            '${snapshot.data![index].address!.city}\nLat: ${snapshot.data![index].address!.geo!.lat}',
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  String title, value;
  ReUsableRow({required this.title, required this.value});

  @override
  build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
