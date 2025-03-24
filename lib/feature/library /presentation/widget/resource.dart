import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/feature/library%20/domain/entities/resource.dart';
import 'package:pva/feature/library%20/presentation/bloc/library_bloc.dart';
import 'package:pva/feature/library%20/presentation/widget/recomended_tile.dart';

class Resources extends StatelessWidget {
  const Resources({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LibraryBloc, LibraryState, List<Resource>>(
      selector: (state){
        if(state is LibraryDataState) {
          return state.filterResources;
        } else {
          return [];
        }
      },
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => RecommendationTile(
            resource: state[index],
          ),
          itemCount: state.length,
        );
      },
    );
  }
}
