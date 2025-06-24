import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {
 // const MovieSlider({Key? key}) : super(key: key);

  final List<Pelicola> filmoteca;
  final String? titulo;
  final Function siguientePagina;

  const MovieSlider({
    Key? key, 
    required this.filmoteca,
    required this.siguientePagina,
    this.titulo,
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderEstado();
}

class _MovieSliderEstado extends State<MovieSlider> {


  final ScrollController scrollController= new ScrollController();

  @override
  void initState() {
    
    super.initState();

    scrollController.addListener(() {
      if(scrollController.position.pixels>=(scrollController.position.maxScrollExtent-300)){

        widget.siguientePagina();
      }

    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //Sitúa el texto en la parte superior izquierda del slider.
        children: [

          if( this.widget.titulo != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20), //El padding se coloca aquí para que no afecte a las imágenes del slider. Sólo debería afecatar al texto.
            child: Text(this.widget.titulo!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          ),

          SizedBox(height: 5,),

          Expanded(//Se necesita para que ListView conozca el tamañano, sino salta error.
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal, //Para que el scroll de la Selección Maldita sea Horizontal y no Vertical, que es el por defecto.
              itemCount: widget.filmoteca.length,
              itemBuilder: ( _ , int index) => _CartelPelicola(widget.filmoteca[index], '${widget.titulo}-${index}-${widget.filmoteca[index].id}') //Retorna el Movie poster
              ),
          )
        ],
      ),
    );
  }
}

class _CartelPelicola extends StatelessWidget { 
  //const _MoviePoster({Key? key}) : super(key: key);

  final Pelicola pelicola;
  final String heroID;

  const _CartelPelicola( this.pelicola, this.heroID );

  @override
  Widget build(BuildContext context) {

    pelicola.heroID= this.heroID;
    return Container(
      width: 130,
      height: 190,
      //color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()=> Navigator.pushNamed(context, 'details', arguments: pelicola),
            child: Hero(
              tag: pelicola.heroID!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(pelicola.fullCaratulaPath),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 5,
          ),
          Text(
            //'Cidade de Deus: Malandros y Favelas',
            pelicola.title,
            maxLines: 2, //Permita dos líneas como máximo en la zona del texto.
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis, //Para que en caso de que no haya suficiente sitio ponga unos puntos suspensivos.
          )
        ]
      ),
    );
  }
}