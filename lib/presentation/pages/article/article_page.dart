import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/domain/entities/article_entity.dart';
import 'package:test_futter_project/presentation/bloc/article/article_page_cubit.dart';

class ArticlePage extends StatefulWidget {
  final String articleId;

  const ArticlePage({required this.articleId, super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late ArticleEntity? article;

  @override
  void initState() {
    super.initState();

    context.read<ArticlePageCubit>().init(widget.articleId);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [Text('Article Title'), Text('Article Summary'), Text('Article Text')],
      ),
    );
  }
}
