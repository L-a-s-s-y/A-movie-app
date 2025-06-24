import 'package:flutter/material.dart';
import 'package:pelicolas/providers/movie_provider.dart';
import 'package:pelicolas/search/search_delegate.dart';
import 'package:pelicolas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final proveedorPelicolas= Provider.of<ProveedorPelicolas>(context);

    //print( moviesProvider.onDisplayMovies );
    return Scaffold(
      appBar: AppBar(
        title: Text('Cintas Perras'),
        elevation: 0,
        actions:[
          IconButton(
            icon: Icon(Icons.search_outlined),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
            )
        ],
      ),
      
      body: SingleChildScrollView(
          child: Column(
        children: [

          //Tarjetas principales
          CardSwipper(filmoteca: proveedorPelicolas.onDisplayPelicolas),

          //Slider
          MovieSlider(
            filmoteca: proveedorPelicolas.popularesPelicolas,
            titulo: 'Selección Maldita',
            siguientePagina: ()=> proveedorPelicolas.getPopularesPelicolas(),
          ),
        ],
      ),
        )
    );
  }
}