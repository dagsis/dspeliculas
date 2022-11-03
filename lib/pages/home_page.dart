import 'package:dspeliculas/providers/movies_provider.dart';
import 'package:dspeliculas/widgets/widgts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    
    final moviesProvieder = Provider.of<MoviesProviders>(context);


    
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en carteleras'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon:Icon( Icons.search_outlined)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             CardSwiper(movies: moviesProvieder.onDisplayMovies,),
             MovieSlider(
                 movies: moviesProvieder.popularMovies,
                 title: 'Mas Vistas',
                  onNextPage: () => {
                     moviesProvieder.getPopularMovies()
                  },
             ),
          ],
        ),
      )
    );
  }
}