import 'package:flutter/material.dart';
import 'package:pelicolas/models/models.dart';
import 'package:pelicolas/widgets/casting_cards.dart';

class PantallaDetalles extends StatelessWidget {

  //const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Pelicola pelicola= ModalRoute.of(context)!.settings.arguments as Pelicola; //EN caso de que sea nulo se manda 'no-movie'.

    //print(movie.title);
    //print('DETAILS SCREEN: ${movie.id}');

    return Scaffold(
      body: CustomScrollView(
        slivers: [ //Widget con cierto comportamiento pre programado cuando se hace scroll en el contenido del padre.
          _CustomAppBar(pelicola),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterEtTitulo(pelicola),
              _Overview(pelicola),
              //_Overview(pelicola),
              //_Overview(pelicola),
              TarjetasElenco(pelicola.id),
            ])
          ),
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  //const _CustomAppBar({Key? key}) : super(key: key);

  final Pelicola pelicola;

  const _CustomAppBar(this.pelicola);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200, //Tamaño de la cabecera
      floating: false,
      pinned: true, //Para que nunca desaparezca del todo la cabecera
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          //'Pelicula.titulo'
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
            pelicola.title,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(pelicola.fullFondoPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterEtTitulo extends StatelessWidget {
  //const _PosterEtTitle({Key? key}) : super(key: key);

  final Pelicola pelicola;

  const _PosterEtTitulo(this.pelicola);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme= Theme.of(context).textTheme;//Evita esta llamada repetidas veces.
    final size= MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: pelicola.heroID!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(pelicola.fullCaratulaPath),
                height: 150,
                //width: 110,
              ),
            ),
          ),
          SizedBox(width: 20,),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width-170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
          
                Text(pelicola.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text(pelicola.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2),
          
                Row(
                  children: [
                    Icon( Icons.star_outline, size: 15, color: Colors.grey), //Estrellita debajo del título
                    SizedBox(width: 5),
                    Text('${pelicola.voteAverage}',style: textTheme.caption,)
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

class _Overview extends StatelessWidget {
  //const _Overview({Key? key}) : super(key: key);

  final Pelicola pelicola;

  const _Overview(this.pelicola);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
      child: Text(
        //'En un lugar de la Mancha, de cuyo nombre no quiero acordarme, no ha mucho tiempo que vivia un hidalgo de los de lanza en astillero, adarga antigua, rocin flaco y galgo corredor. Una olla de algo mas vaca que carnero, salpicon las mas noches, duelos y quebrantos los sabados, lantejas los viernes, algun palomino de añadidura los domingos, consumian las tres partes de su hacienda.',
        pelicola.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      )
    );
  }
}