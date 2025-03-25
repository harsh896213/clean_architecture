import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/image_path/image_path.dart';
import 'package:pva/core/theme/app_pallete.dart';
import 'package:pva/core/theme/shadow.dart';
import 'package:pva/core/widgets/svg_button_container.dart';
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
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: cardShadow,
      ),
      child: Row(
        children: [
          SvgButtonContainer(
            svgPath: ImagePath.document,
            size: 20,
            color: AppPallete.iconBg,
            padding: 10,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  documentEntity.title,
                  maxLines: 1,
                  style: context.textTheme.titleSmall,
                ),
                const SizedBox(height: 4,),
                Text(
                  documentEntity.desc,
                  maxLines: 1,
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8,),
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
          SvgPicture.asset(ImagePath.download, width: 20, height: 20,),
        ],
      ),
    );
  }
}
