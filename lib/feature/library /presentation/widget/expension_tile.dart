import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/core/widgets/library_expansion_tile.dart';
import 'package:pva/feature/library%20/domain/entities/frequently_asked_question.dart';
import 'package:pva/feature/library%20/presentation/bloc/library_bloc.dart';

class FrequentlyAskedQuestion extends StatelessWidget {
  const FrequentlyAskedQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LibraryBloc, LibraryState, List<FrequentlyAskedQuestionEntity>>(
      selector: (state) {
       if(state is LibraryDataState){
         return state.filterAskedQuestion;
       }
       else{
         return [];
       }
      },
      builder: (context, state) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          itemCount: state.length,
          // Replace with your actual count
          itemBuilder: (context, index) {
            return LibraryExpansionTile(
              key: ValueKey(index),
              title: state[index].title,
              detailedDescription: state[index].desc,
              isExpanded: state[index].isOpen,
              onExpansionChanged: (isExpanded) {
                context.read<LibraryBloc>().add(
                    ToggleAskedQuestion(frequentlyAskedQuestion: state[index]));
                });
              },
            );
          },
        );
      }
  }
