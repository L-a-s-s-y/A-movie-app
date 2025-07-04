import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pelicolas/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class TarjetasElenco extends StatelessWidget {
  //const CastingCards({Key? key}) : super(key: key);

  final int pelicolaID;

  const TarjetasElenco(this.pelicolaID);

  @override
  Widget build(BuildContext context) {
    //print('CASTING CARDS: $movieID');
    final proveedorPelicolas= Provider.of<ProveedorPelicolas>(context, listen: false);

    return FutureBuilder(
      
      future: proveedorPelicolas.getElencoPelicola(pelicolaID),
      builder: ( _, AsyncSnapshot<List<Elenco>> snapshot){

        if(!snapshot.hasData){
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Elenco> elenco= snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          // color: Colors.red,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index)=>_TarjetaElenco(elenco[index])
          ),
        );
      },
    );

    
  }
}

class _TarjetaElenco extends StatelessWidget {
  //const _CastCard({Key? key}) : super(key: key);

  final Elenco actor;

  const _TarjetaElenco( this.actor );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      //color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              //image: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover
            )
          ),
          SizedBox(height: 5,),
          Text(
            //'actor.name mucho muchisimo tesxto jejeej',
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}