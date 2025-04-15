import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/widgets/custom_app_bar.dart';

import '../widget/document_card.dart';
import '../widget/mini_profile_information_card.dart';

class ConsentDocumentPage extends StatelessWidget {
  const ConsentDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'Consent Documents',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        titleColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            MiniProfileCard(
                imageUrl: 'assets/profile_image.png',
                name: 'Simon Riley',
                patientId: '89373652',
                gender: 'Male',
                age: 52,
              ),

            const Divider(height: 1, thickness: 1),

            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: DocumentCardsGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class DocumentCardsGrid extends StatelessWidget {
  const DocumentCardsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;

    int crossAxisCount;
    if (context.isMobile) {
      crossAxisCount = isLandscape ? 3 : 2;
    } else {
      crossAxisCount = isLandscape ? 4 : 3;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: const [
            DocumentCard(
              title: 'Exercise Instruction',
              fileType: 'DOC',
              fileSize: '683 kb',
            ),
            DocumentCard(
              title: 'Medication Instructions',
              fileType: 'DOC',
              fileSize: '683 kb',
            ),
            DocumentCard(
              title: 'Diet Plan This Month',
              fileType: 'DOC',
              fileSize: '683 kb',
            ),
            DocumentCard(
              title: 'Exercise Instruction',
              fileType: 'PDF',
              fileSize: '683 kb',
            ),
          ],
        );
      },
    );
  }
}
