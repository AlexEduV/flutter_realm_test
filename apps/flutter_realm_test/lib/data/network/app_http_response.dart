import 'package:http/http.dart';

class AppHttpResponse extends Response {
  AppHttpResponse(super.body, super.statusCode);

  static AppHttpResponse fromHttp(Response response) =>
      AppHttpResponse(response.body, response.statusCode);
}
