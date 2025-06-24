

import 'package:flutter/material.dart';
import 'package:pelicolas/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:pelicolas/models/models.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [

      IconButton(
        icon: Icon(Icons.clear),
        onPressed: ()=>query='',        
      )

    ];

  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      }, 

    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return Text('Build Results');
  }

  Widget _emptyContainer(){
    return Container(
        child: Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 100,)
        ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {


    if(query.isEmpty){
      return _emptyContainer();
    }

    final moviesProvider= Provider.of<ProveedorPelicolas>(context, listen: false);
    moviesProvider.getSugerenciasPorQuery(query);

    return StreamBuilder(
      stream: moviesProvider.streamSugerencias,
      builder: (_, AsyncSnapshot<List<Pelicola>> snapshot){
        if(!snapshot.hasData){
          return _emptyContainer();
        }

        final movies= snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index)=>_MovieItem(movies[index])
        );
      }
    );

    
  }

}

class _MovieItem extends StatelessWidget {

  final Pelicola movie;

  const _MovieItem(this.movie);


  @override
  Widget build(BuildContext context) {

    movie.heroID= 'movie_search-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroID!,
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullCaratulaPath),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: (){
        //print(movie.title);
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}