//===================================================================
// File: main.dart
//
// Desc: Main entry point for app.
//
// Copyright © 2019 Edwin Cloud. All rights reserved.
//
// * Attribution to Tensor and his channel on YouTube at      *
// * https://www.youtube.com/channel/UCYqCZOwHbnPwyjawKfE21wg *
//===================================================================

//-------------------------------------------------------------------
// Imports
//-------------------------------------------------------------------
import 'package:flutter/material.dart';

// main function
void main() => runApp(MyApp());

//-------------------------------------------------------------------
// MyApp (Stateless Widget Class) - Root Widget
//-------------------------------------------------------------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      theme: ThemeData.dark(),
      home: HomeView(),
    );
  }
}

//-------------------------------------------------------------------
// HomeView (Stateful Widget Class)
//-------------------------------------------------------------------
class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

//-------------------------------------------------------------------
// _HomeViewState (HomeView State) - Home Page View
//-------------------------------------------------------------------
class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
