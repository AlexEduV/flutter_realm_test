abstract class UseCaseNoParams<Output> {
  Output call();
}

abstract class UseCaseWithParams<Output, Input> {
  Output call(Input params);
}
