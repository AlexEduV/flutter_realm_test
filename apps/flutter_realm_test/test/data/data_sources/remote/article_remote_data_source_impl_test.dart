//todo: the data source is not mockable;
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   late MockArticleRepository mockArticleRepository;
//   late MockArticleRemoteDataSourceImpl mockArticleService;
//
//   setUp(() {
//     mockArticleRepository = MockArticleRepository();
//     mockArticleService = MockArticleRemoteDataSourceImpl();
//   });
//
//   group('MockArticleService', () {
//     test('fetchArticles returns list of articles from repository', () async {
//       final articles = [
//         const ArticleEntity(
//           id: '1',
//           title: 'Test 1',
//           summary: 'Content 1',
//           paragraphs: [],
//           author: AuthorEntity(id: 'testId', fullName: 'Jennifer Morrison'),
//           datePublished: '',
//         ),
//         const ArticleEntity(
//           id: '2',
//           title: 'Test 2',
//           summary: 'Content 2',
//           paragraphs: [],
//           author: AuthorEntity(id: 'testId', fullName: 'Jennifer Morrison'),
//           datePublished: '',
//         ),
//       ];
//
//       when(mockArticleRepository.fetchArticles()).thenAnswer((_) async => articles);
//
//       final result = await mockArticleService.fetchArticles();
//
//       expect(result, articles);
//       verify(mockArticleRepository.fetchArticles()).called(1);
//     });
//
//     test('getArticleById returns article from repository', () async {
//       final article = const ArticleEntity(
//         id: '1',
//         title: 'Test 1',
//         summary: 'Content 1',
//         paragraphs: [],
//         author: AuthorEntity(id: 'testId', fullName: 'Jennifer Morrison'),
//         datePublished: '',
//       );
//
//       when(mockArticleRepository.getArticleById('1')).thenAnswer((_) async => article);
//
//       final result = await mockArticleService.getArticleById('1');
//
//       expect(result, article);
//       verify(mockArticleRepository.getArticleById('1')).called(1);
//     });
//   });
// }

void main() {}
