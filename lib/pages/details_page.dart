import 'package:dspeliculas/widgets/casting_cards.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    
    return Scaffold(

      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
                _PosterAndTitle(),
                _Overview(),
                _Overview(),
                _Overview(),
                CastingCard()
               ]),
          ),
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title:Container(
          padding: EdgeInsets.only(bottom: 10),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text('movie-title',style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            ),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/400x300.png'),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}
class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300.png'),
              height: 150,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'movie.title', style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,maxLines: 2
              ),
              Text(
                  'movie.original.title', style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis
              ),
              Row(
                children: [
                  Icon(Icons.star_outline,size: 15,color: Colors.grey),
                  SizedBox(width: 5),
                  Text('movie.voteAverage',style:textTheme.caption,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Text('Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum"',
             textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),

    );
  }
}



