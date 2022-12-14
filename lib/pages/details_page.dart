import 'package:dspeliculas/models/movie.dart';
import 'package:dspeliculas/widgets/casting_cards.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    
    return Scaffold(

      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
              delegate: SliverChildListDelegate([
                _PosterAndTitle(movie: movie),
                _Overview(overview: movie.overview),
                CastingCard(movieId: movie.id,)
               ]),
          ),
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key,
    required this.movie}) : super(key: key);

  final Movie movie;



  @override
  Widget build(BuildContext context) {

   // print('Full : ${movie.fullBackupPath}');

    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title:Container(
          padding: EdgeInsets.only(bottom: 10,left: 10,right: 10),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(movie.title,style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullbackdropPath),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}
class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({
    Key? key,
    required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;


    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fulPosterImg),
                height: 150,
              ),
            ),
          ),
          SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    movie.title, style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,maxLines: 2
                ),

                Text(
                    movie.originalTitle, style: textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,maxLines: 2,
                ),
                Row(
                  children: [
                    Icon(Icons.star_outline,size: 15,color: Colors.grey),
                    SizedBox(width: 5),
                    Text(movie.voteAverage.toString(),style:textTheme.caption,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({Key? key,
      required this.overview}) : super(key: key);

  final String overview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Text( this.overview,
             textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),

    );
  }
}



