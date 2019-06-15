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
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weather_commands.dart';
import 'package:weather_app/models/weather_provider.dart';
import 'package:weather_app/repositories/weather.dart';
import 'package:http/http.dart' as http;
import 'package:rx_widgets/rx_widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_app/locale/locales.dart';

// main function
void main() {
  final repo = WeatherRepository(client: http.Client());
  final weatherCommands = WeatherCommands(repo);

  runApp(WeatherProvider(
    weatherCommands: weatherCommands,
    child: MyApp(),
  ));
}

//-------------------------------------------------------------------
// MyApp (Stateless Widget Class) - Root Widget
//-------------------------------------------------------------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
        Locale('ja', ''),
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context).title,
      theme: ThemeData.dark(),
      home: HomeView(),
    );
  }
}

//-------------------------------------------------------------------
// HomeView (Stateful Widget Class)
//-------------------------------------------------------------------
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

//-------------------------------------------------------------------
// _HomeViewState (HomeView State) - Home Page View
//-------------------------------------------------------------------
class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    WeatherProvider.of(context)
        .changeLocaleCommand
        .call(myLocale.languageCode.toString());
    WeatherProvider.of(context).getGpsCommand.call();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).title,
          style: TextStyle(
            fontSize:
                myLocale.languageCode.contains('en') ? 20.0 : 15.0,
          ),
        ),
        actions: <Widget>[
          Container(
            child: Center(
              child: RxLoader<bool>(
                radius: 20.0,
                commandResults:
                    WeatherProvider.of(context).getGpsCommand.results,
                dataBuilder: (context, data) =>
                    Text(data ? "GPS Active" : "GPS Inactive"),
                placeHolderBuilder: (context) =>
                    Text("Push the Button"),
                errorBuilder: (context, exception) =>
                    Text("$exception"),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.gps_fixed),
            onPressed: WeatherProvider.of(context).getGpsCommand,
          ),
          PopupMenuButton<int>(
            padding: EdgeInsets.all(1.0),
            tooltip: "Select how many cities to load",
            onSelected: (int item) {
              WeatherProvider.of(context).addCitiesCommand(item);
            },
            itemBuilder: (context) {
              final menuNumbers = <int>[
                5,
                10,
                15,
                20,
                25,
                30,
                35,
                40,
                45,
                50
              ];
              return menuNumbers
                  .map((number) => PopupMenuItem(
                        value: number,
                        child: Center(
                          child: Text(number.toString()),
                        ),
                      ))
                  .toList();
            },
          )
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Expanded(
            child: RxLoader<List<WeatherModel>>(
              radius: 30.0,
              commandResults: WeatherProvider.of(context)
                  .updateWeatherCommand
                  .results,
              dataBuilder: (context, data) => WeatherList(data),
              placeHolderBuilder: (context) => Center(
                    child: Text("No Data"),
                  ),
              errorBuilder: (context, exception) =>
                  Center(child: Text("$exception")),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: WidgetSelector(
                    buildEvents: WeatherProvider.of(context)
                        .updateLocationCommand
                        .canExecute,
                    onTrue: MaterialButton(
                      elevation: 5.0,
                      color: Colors.blueGrey,
                      child: Text(
                          AppLocalizations.of(context).buttonText),
                      onPressed: WeatherProvider.of(context)
                          .updateLocationCommand
                          .execute,
                    ),
                    onFalse: MaterialButton(
                      elevation: 0.0,
                      color: Colors.blueGrey[100],
                      child: Text("Loading ..."),
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SliderItem(
                        sliderState: true,
                        command: WeatherProvider.of(context)
                            .radioCheckedCommand,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Turn off Data"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//-------------------------------------------------------------------
// WeatherList (Stateless Widget Class) - Weather Results List
// Widget
//-------------------------------------------------------------------
class WeatherList extends StatelessWidget {
  // class variables
  final List<WeatherModel> list;

  //constuctor
  WeatherList(this.list);

  // build widget
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => ListTile(
            leading: Image.network(
                "http://openweathermap.org/img/w/${list[index].icon.toString()}.png"),
            title: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(list[index].city.toString()),
            ),
            subtitle: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                  "${list[index].temperature.toStringAsFixed(2)}°"),
            ),
            trailing: Container(
              child: Column(
                children: <Widget>[
                  Text(list[index].description),
                  Container(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      "Latitude: ${list[index].lat}",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Longitude: ${list[index].long}",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}

//-------------------------------------------------------------------
// SliderItem (Stateful Widget Class)
//-------------------------------------------------------------------
class SliderItem extends StatefulWidget {
  // class variables
  final bool sliderState;
  final ValueChanged<bool> command;

  // constructor
  SliderItem({this.sliderState, this.command});

  // create state
  _SliderItemState createState() =>
      _SliderItemState(sliderState, command);
}

//-------------------------------------------------------------------
// _SliderItemState (Slider Item State) - A Slider Item
//-------------------------------------------------------------------
class _SliderItemState extends State<SliderItem> {
  // class variables (State)
  bool sliderState;
  ValueChanged<bool> command;

  // constructor
  _SliderItemState(this.sliderState, this.command);

  // build widget
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: sliderState,
      onChanged: (item) {
        setState(() {
          sliderState = item;
          command(item);
        });
      },
    );
  }
}
