import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/common/app_dimensions.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/bloc/article/article_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/article/article_page_state.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../common/app_colors.dart';

class ArticlePage extends StatefulWidget {
  final String articleId;

  const ArticlePage({required this.articleId, super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  void initState() {
    super.initState();

    context.read<ArticlePageCubit>().init(widget.articleId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlePageCubit, ArticlePageState>(
      builder: (context, state) {
        final minsToRead = state.article?.minsToRead;

        return Scaffold(
          appBar: AppBar(
            title: Text(state.article?.title ?? '', style: AppTextStyles.zonaPro20),
            centerTitle: true,
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: AppDimensions.normalL),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppDimensions.normalL,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppDimensions.normalL),
                          child: CachedNetworkImage(
                            imageUrl: state.article?.imageUrl ?? '',
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                            placeholder: (context, url) =>
                                Container(color: AppColors.placeholderColor),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            color: Colors.black.withAlpha(70),
                            colorBlendMode: BlendMode.darken,
                          ),
                        ),

                        Row(
                          spacing: AppDimensions.minorL,
                          children: [
                            if (minsToRead != null) ...[
                              Text(
                                '${state.article?.minsToRead} ${AppLocalisations.articlePageMinsToRead}',
                              ),
                            ],

                            Text(state.article?.datePublished ?? ''),
                          ],
                        ),

                        Row(
                          spacing: AppDimensions.minorL,
                          children: [
                            const CircleAvatar(radius: AppDimensions.normalS),
                            Text(
                              state.article?.authorFullName ?? '',
                              style: AppTextStyles.zonaPro14,
                            ),
                          ],
                        ),

                        Text(
                          state.article?.summary ?? '',
                          style: AppTextStyles.zonaPro14.copyWith(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        ...?state.article?.paragraphs.map(
                          (paragraph) => Text(
                            paragraph,
                            style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),

                        const SizedBox(height: AppDimensions.normalL),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
