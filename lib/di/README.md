# Dependency injection

### General information

In the project, I am using service locator pattern, which means I register all the DI
objects in one place and then call them by using `serviceLocator<T>()` where I need them.

I am not using `Injectable` package. While it might reduce boilerplate, the project is too small to
justify the constant regeneration of dependencies.

### Recommendations

Register cubits as `factory` for most cases. Use `singletons` or `lazySingletons` only for cubits that should persist for
the whole app session.

UseCases, Services, Repositories, and Utilities should be registered as `singletons`

Models and Entities are not registered.


---

[Official Docs](https://pub.dev/packages/get_it)