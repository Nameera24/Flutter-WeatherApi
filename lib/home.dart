import 'package:flutter/material.dart';
import 'package:flutter_application_11/data_service.dart';
import 'package:flutter_application_11/model.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  late WeatherResponse _response;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Weather App",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
          child: Stack(children: [
        Image.asset(
          "clear.png",
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_response != null)
              Column(
                children: [
                  Image.network(_response.iconUrl),
                  Text(
                    '${_response.tempInfo.temperature}°',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(_response.weatherInfo.description)
                ],
              ),
            Column(
              children: [
                Center(
                  child: Container(
                    width: 500,
                    child: TextField(
                        controller: _cityTextController,
                        decoration: InputDecoration(labelText: 'City'),
                        textAlign: TextAlign.center),
                  ),
                ),
                ElevatedButton(onPressed: _search, child: Text('Search'))
              ],
            )
          ],
        ),
      ])),
    );
  }

  void _search() async {
    final response1 = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response1);
  }
}
