import 'package:dspeliculas/models/movie.dart';
import 'package:dspeliculas/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate  extends SearchDelegate {

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar pelicula.....';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [ 
       IconButton(onPressed: () {
         query = '';
       },
           icon: Icon(Icons.clear)
       )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return   IconButton(onPressed: () {
         close(context, null);
    },
        icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return  Text('buidResult');
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Icon(Icons.movie_creation_outlined,color: Colors.black38,size: 100,),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if (query.isEmpty){
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProviders>(context,listen: false);
    moviesProvider.getSuggestionByQuery(query);

    return StreamBuilder(
        stream: moviesProvider.suggestionStream,
        builder: (_ ,AsyncSnapshot<List<Movie>> snashop) {
          if (!snashop.hasData) return _emptyContainer();

          final movies = snashop.data!;

          return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (_,
                int index) =>_MovieItem(movie: movies[index])

          );
        },
    );
  }
}

class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({super.key,
    required this.movie});

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fulPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.releaseDate.toString()),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
