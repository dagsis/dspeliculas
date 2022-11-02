import 'package:dspeliculas/widgets/widgts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
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
             CardSwiper(),
             MovieSlider()
          ],
        ),
      )
    );
  }
}