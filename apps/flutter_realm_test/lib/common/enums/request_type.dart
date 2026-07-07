enum HttpRequestType {
  get('GET'),
  post('POST');

  const HttpRequestType(this.name);

  final String name;
}
