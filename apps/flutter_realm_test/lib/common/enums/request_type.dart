enum HttpRequestType {
  get('GET'),
  post('POST');

  final String name;

  const HttpRequestType(this.name);
}
