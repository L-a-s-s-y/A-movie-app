import 'package:flutter/material.dart';
import 'package:pelicolas/providers/movie_provider.dart';
import 'package:pelicolas/screens/screen.dart';
import 'package:provider/provider.dart';
//import '';



//void main() => runApp(MyApp());
void main()=>runApp(AppState());

class AppState extends StatelessWidget {
  //const AppState({Key? key}) : super//(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ )=>ProveedorPelicolas(), lazy: false)
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: 'home',
      routes: {
        'home':( _ )=>HomeScreen(),
        'details':( _ )=>PantallaDetalles(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.indigo
        )
      ),
    );
  }
}