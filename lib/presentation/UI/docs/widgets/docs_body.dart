import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/docs/widgets/docs_card.dart';
import 'package:htql_app/presentation/UI/docs/widgets/docs_search_field.dart';
import 'package:htql_app/presentation/provider/docs_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:provider/provider.dart';

class DocsBody extends StatelessWidget {
  const DocsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DocsProvider>(
      builder: (context, docsProvider, child) {
        final documents = docsProvider.filteredDocuments;
        final primaryTextColor = AppColor.primaryTextColor(context);

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 56, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Tài liệu',
                textAlign: TextAlign.left,
                style: AppTextstyle.tsBoldBlack20.copyWith(
                  color: primaryTextColor,
                ),
              ),
              SizedBox(height: 14),
              DocsSearchField(
                value: docsProvider.searchKeyword,
                onChanged: docsProvider.setSearchKeyword,
              ),
              SizedBox(height: 16),
              if (documents.isEmpty)
                _EmptyDocs()
              else
                ...documents.map(
                  (document) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DocsCard(
                      document: document,
                      isExpanded:
                          docsProvider.expandedDocumentId == document.id,
                      onTap: () {
                        docsProvider.toggleDocument(document.id);
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyDocs extends StatelessWidget {
  const _EmptyDocs();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: AppText(
        text: 'Không tìm thấy tài liệu',
        textAlign: TextAlign.left,
        style: AppTextstyle.tsMediumGrey14.copyWith(
          color: AppColor.secondaryTextColor(context),
        ),
      ),
    );
  }
}
