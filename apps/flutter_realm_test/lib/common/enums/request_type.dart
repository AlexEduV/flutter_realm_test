enum HttpRequestType {
  get('GET'),
  post('POST');

  final String label;

  const HttpRequestType(this.label);
}
