import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:transparent_image/transparent_image.dart';

/// Intercepts all HTTP image requests and returns a 1x1 transparent image.
/// Use via [HttpOverrides.global] in setUp/tearDown for tests that render
/// network images (NetworkImage, FadeInImage.memoryNetwork, etc.).
class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => _FakeHttpClient();
}

class _FakeHttpClient implements HttpClient {
  @override
  bool autoUncompress = true;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _FakeHttpClientRequest();

  // Unused HttpClient members — only getUrl is exercised by image loading.
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpClientRequest implements HttpClientRequest {
  @override
  final HttpHeaders headers = _FakeHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => _FakeHttpClientResponse();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpHeaders implements HttpHeaders {
  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {}

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpClientResponse implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => kTransparentImage.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) => Stream<List<int>>.fromIterable([
    kTransparentImage,
  ]).listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Returns a 1x1 transparent image for any image asset key, and delegates
/// all other keys (manifests, fonts, etc.) to [rootBundle].
/// Wrap the widget under test in [DefaultAssetBundle] to use it:
///   DefaultAssetBundle(bundle: FakeAssetBundle(), child: ...)
class FakeAssetBundle extends CachingAssetBundle {
  static const _imageExtensions = {'.png', '.jpg', '.jpeg', '.gif', '.webp'};

  @override
  Future<ByteData> load(String key) async {
    if (_imageExtensions.any(key.endsWith)) {
      return ByteData.view(Uint8List.fromList(kTransparentImage).buffer);
    }
    return rootBundle.load(key);
  }
}
