import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String apiKey = '8a2ab99142a9dbb4f0e75c13e899419c';
  String weatherData = '';
  TextEditingController searchController = TextEditingController();

  void fetchWeatherData(String cityName) async {
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';
    http.Response response = await http.get(Uri.parse(apiUrl));
    setState(() {
      weatherData = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Add City',style: TextStyle(color: Colors.black),),centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Enter a city name',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String cityName = searchController.text;
                fetchWeatherData(cityName);
              },
              child: Text('Get Weather'),
            ),
            SizedBox(height: 20.0),
            Text(
              weatherData.isNotEmpty ? weatherData : 'No data',
            ),
          ],
        ),
      ),
    );
  }
}