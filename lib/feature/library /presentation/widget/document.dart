import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/theme/shadow.dart';
import 'package:pva/core/theme/text_styles.dart';
import 'package:pva/feature/library%20/domain/entities/document.dart';
import 'package:pva/feature/library%20/presentation/bloc/library_bloc.dart';

class Document extends StatelessWidget {
  const Document({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LibraryBloc, LibraryState, List<DocumentEntity>>(
      selector: (state) {
        if(state is LibraryDataState){
          return state.filterDocument;
        }
        else{
          return [];
        }
      },
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 15),
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) =>
              SizedBox(
                height: 10,
              ),
          shrinkWrap: true,
          itemBuilder: (context, index) => DocumentTile(documentEntity: state[index],),
          itemCount: state.length,
        );
      },
    );
  }
}

class DocumentTile extends StatelessWidget {
  final DocumentEntity documentEntity;

  const DocumentTile({required this.documentEntity,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: cardShadow,
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                decoration: const ShapeDecoration(
                  color: Color(0xFFEEF2F5),
                  shape: CircleBorder(),
                ),
                child: Icon(
                  Icons.file_present,
                  color: Colors.blue,
                )),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    documentEntity.title,
                    maxLines: 1,
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    documentEntity.desc,
                    maxLines: 1,
                    style: context.textTheme.bodyMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PDF * 1.8 MB",
                        maxLines: 1,
                        style: context.textTheme.labelMedium
                            ?.copyWith(fontSize: 12),
                      ),
                      Text(
                        "Feb 14, 2025",
                        maxLines: 1,
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              CupertinoIcons.arrow_down_to_line,
              color: Colors.blue,
              size: 30,
            ),

          ],
        ),
      ),
    );
  }
}
