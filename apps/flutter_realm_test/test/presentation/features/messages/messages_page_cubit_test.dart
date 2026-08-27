import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/attachment_entity.dart';
import 'package:test_flutter_project/domain/entities/gif_entity.dart';
import 'package:test_flutter_project/domain/repositories/file_picker_repository.dart';
import 'package:test_flutter_project/domain/repositories/owner_repository.dart';
import 'package:test_flutter_project/domain/usecases/gifs/get_trending_gifs_use_case.dart';
import 'package:test_flutter_project/domain/usecases/gifs/search_gifs_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/extract_users_from_conversation_use_case.dart';
import 'package:test_flutter_project/domain/usecases/inbox/get_conversation_by_id_use_case.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/messages/messages_page_state.dart';
import 'package:test_flutter_project/utils/date_formatter.dart';

import 'messages_page_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FilePickerRepository>(),
  MockSpec<OwnerRepository>(),
  MockSpec<SearchGifsUseCase>(),
  MockSpec<GetTrendingGifsUseCase>(),
  MockSpec<GetConversationByIdUseCase>(),
  MockSpec<ExtractUsersFromConversationUseCase>(),
  MockSpec<DateFormatter>(),
])
void main() {
  late MockFilePickerRepository mockFilePickerRepository;
  late MockOwnerRepository mockOwnerRepository;
  late MockSearchGifsUseCase mockSearchGifsUseCase;
  late MockGetTrendingGifsUseCase mockGetTrendingGifsUseCase;
  late MockGetConversationByIdUseCase mockGetConversationByIdUseCase;
  late MockExtractUsersFromConversationUseCase mockExtractUsersFromConversationUseCase;
  late MockDateFormatter mockDateFormatter;
  late MessagesPageCubit cubit;

  setUp(() {
    mockFilePickerRepository = MockFilePickerRepository();
    mockOwnerRepository = MockOwnerRepository();
    mockSearchGifsUseCase = MockSearchGifsUseCase();
    mockGetTrendingGifsUseCase = MockGetTrendingGifsUseCase();
    mockGetConversationByIdUseCase = MockGetConversationByIdUseCase();
    mockExtractUsersFromConversationUseCase = MockExtractUsersFromConversationUseCase();
    mockDateFormatter = MockDateFormatter();
    cubit = MessagesPageCubit(
      mockFilePickerRepository,
      mockOwnerRepository,
      mockSearchGifsUseCase,
      mockGetTrendingGifsUseCase,
      mockGetConversationByIdUseCase,
      mockExtractUsersFromConversationUseCase,
      mockDateFormatter,
    );
  });

  test('initial state is MessagesPageState()', () {
    expect(cubit.state, const MessagesPageState());
  });

  blocTest<MessagesPageCubit, MessagesPageState>(
    'setCurrentConversationId emits updated state',
    build: () => cubit,
    act: (cubit) => cubit.setCurrentConversationId('conv123'),
    expect: () => [const MessagesPageState().copyWith(currentConversationId: 'conv123')],
  );

  blocTest<MessagesPageCubit, MessagesPageState>(
    'updateMessageText emits updated state',
    build: () => cubit,
    act: (cubit) => cubit.updateMessageText('Hello!'),
    expect: () => [const MessagesPageState().copyWith(currentMessageText: 'Hello!')],
  );

  blocTest<MessagesPageCubit, MessagesPageState>(
    'updateGifsSearch emits loading and result states for trending gifs when query is empty',
    build: () {
      when(mockGetTrendingGifsUseCase.call()).thenAnswer(
        (_) async => Right([
          GifEntity(
            id: '1',
            title: 'Trending',
            previewImageUrl: 'preview',
            imageUrl: 'image',
            width: 100,
            height: 100,
          ),
        ]),
      );
      return cubit;
    },
    act: (cubit) => cubit.updateGifsSearch(''),
    expect: () => [
      const MessagesPageState().copyWith(currentGifSearchText: ''),
      const MessagesPageState().copyWith(currentGifSearchText: '', areGifsLoading: true),
      const MessagesPageState().copyWith(
        currentGifSearchText: '',
        areGifsLoading: true,
        gifsInSearch: [
          GifEntity(
            id: '1',
            title: 'Trending',
            previewImageUrl: 'preview',
            imageUrl: 'image',
            width: 100,
            height: 100,
          ),
        ],
      ),
      const MessagesPageState().copyWith(
        currentGifSearchText: '',
        areGifsLoading: false,
        gifsInSearch: [
          GifEntity(
            id: '1',
            title: 'Trending',
            previewImageUrl: 'preview',
            imageUrl: 'image',
            width: 100,
            height: 100,
          ),
        ],
        latestQuery: '',
      ),
    ],
  );

  blocTest<MessagesPageCubit, MessagesPageState>(
    'updateGifsSearch emits loading and result states for search gifs when query is not empty',
    build: () {
      when(mockSearchGifsUseCase.call('cat')).thenAnswer(
        (_) async => Right([
          GifEntity(
            id: '2',
            title: 'Cat',
            previewImageUrl: 'preview2',
            imageUrl: 'image2',
            width: 200,
            height: 200,
          ),
        ]),
      );
      return cubit;
    },
    act: (cubit) => cubit.updateGifsSearch('cat'),
    expect: () => [
      const MessagesPageState().copyWith(currentGifSearchText: 'cat'),
      const MessagesPageState().copyWith(currentGifSearchText: 'cat', areGifsLoading: true),
      const MessagesPageState().copyWith(
        currentGifSearchText: 'cat',
        areGifsLoading: true,
        gifsInSearch: [
          GifEntity(
            id: '2',
            title: 'Cat',
            previewImageUrl: 'preview2',
            imageUrl: 'image2',
            width: 200,
            height: 200,
          ),
        ],
      ),
      const MessagesPageState().copyWith(
        currentGifSearchText: 'cat',
        areGifsLoading: false,
        gifsInSearch: [
          GifEntity(
            id: '2',
            title: 'Cat',
            previewImageUrl: 'preview2',
            imageUrl: 'image2',
            width: 200,
            height: 200,
          ),
        ],
        latestQuery: 'cat',
      ),
    ],
  );

  blocTest<MessagesPageCubit, MessagesPageState>(
    'updateSelectedGif emits updated state',
    build: () => cubit,
    act: (cubit) => cubit.updateSelectedGif('gif_url'),
    expect: () => [const MessagesPageState().copyWith(selectedGif: 'gif_url')],
  );

  test('getAttachmentFile returns result from use case', () async {
    final attachment = AttachmentEntity(name: 'a1', path: 'file_url', size: 12);
    when(mockFilePickerRepository.pickFile()).thenAnswer((_) async => attachment);

    final result = await cubit.getAttachmentFile();

    expect(result, attachment);
    verify(mockFilePickerRepository.pickFile()).called(1);
  });

  test('getAttachmentFile returns null if use case returns null', () async {
    when(mockFilePickerRepository.pickFile()).thenAnswer((_) async => null);

    final result = await cubit.getAttachmentFile();

    expect(result, isNull);
    verify(mockFilePickerRepository.pickFile()).called(1);
  });
}
