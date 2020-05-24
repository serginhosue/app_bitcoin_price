import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _bicoinPrice = "";
  NumberFormat _format = NumberFormat('#,###,###.00');

  void _findBitcoinPrice() async{
    String url = "https://blockchain.info/ticker";

    http.Response response;

    response = await http.get(url);

    Map<String, dynamic> _mapBitcoinPrice = json.decode(response.body);

    if(_mapBitcoinPrice["BRL"]["buy"] != null){
      double _price = _mapBitcoinPrice["BRL"]["buy"];
      setState(() {
        _bicoinPrice = _format.format(_price).toString();
      });
    }
  }

  void _zerarConsulta(){
    setState(() {
      _bicoinPrice = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset("assets/images/bitcoin.png"),
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                  "R\$ ${_bicoinPrice}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: RaisedButton(
                color: Colors.orange,
                onPressed: _findBitcoinPrice,
                child: Text(
                  "Consultar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: RaisedButton(
                color: Colors.orange,
                onPressed: _zerarConsulta,
                child: Text(
                  "Zerar Consulta",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            )
          ],
        
        ),
      ),
    );
  }
}
