import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/attachment_entity.dart';
import 'package:test_futter_project/domain/entities/gif_entity.dart';
import 'package:test_futter_project/domain/usecases/file_picker/pick_attachment_file_use_case.dart';
import 'package:test_futter_project/domain/usecases/gifs/get_trending_gifs_use_case.dart';
import 'package:test_futter_project/domain/usecases/gifs/search_gifs_use_case.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_futter_project/presentation/bloc/messages/messages_page_state.dart';

import 'messages_page_cubit_test.mocks.dart';

@GenerateMocks([SearchGifsUseCase, GetTrendingGifsUseCase, PickAttachmentFileUseCase])
void main() {
  late MockSearchGifsUseCase mockSearchGifsUseCase;
  late MockGetTrendingGifsUseCase mockGetTrendingGifsUseCase;
  late MockPickAttachmentFileUseCase mockPickAttachmentFileUseCase;
  late MessagesPageCubit cubit;

  setUp(() {
    mockSearchGifsUseCase = MockSearchGifsUseCase();
    mockGetTrendingGifsUseCase = MockGetTrendingGifsUseCase();
    mockPickAttachmentFileUseCase = MockPickAttachmentFileUseCase();
    cubit = MessagesPageCubit(
      mockSearchGifsUseCase,
      mockGetTrendingGifsUseCase,
      mockPickAttachmentFileUseCase,
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
      const MessagesPageState().copyWith(currentGifSearchText: '', areGifsLoading: true),
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
    when(mockPickAttachmentFileUseCase.call()).thenAnswer((_) async => attachment);

    final result = await cubit.getAttachmentFile();

    expect(result, attachment);
    verify(mockPickAttachmentFileUseCase.call()).called(1);
  });

  test('getAttachmentFile returns null if use case returns null', () async {
    when(mockPickAttachmentFileUseCase.call()).thenAnswer((_) async => null);

    final result = await cubit.getAttachmentFile();

    expect(result, isNull);
    verify(mockPickAttachmentFileUseCase.call()).called(1);
  });
}
