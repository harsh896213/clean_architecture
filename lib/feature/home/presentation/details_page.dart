import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl:
    "https://images.pexels.com/photos/20879653/pexels-photo-20879653/free-photo-of-ethiopians-taking-part-in-an-orthodox-religious-festival.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
    );
  }
}
