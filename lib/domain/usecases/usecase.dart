abstract class UseCase<Output, Input> {
  Future<Output> call(Input params);
}
