## General

# the design used for the project: https://dribbble.com/shots/17097339-Vehicle-Retailer-App

# the app uses location markers, so needs location permissions. Use permission_handler for it;
# navigation will include GoRouter with custom RouteTypes;
# need to add an api for images; try to use rx_dart for it;

# tree shaking includes 'show' identifier; it does not look well for Material library.

# The project uses Cubit for State management, and avoid using SetState where possible.

# Include semantics for interactive elements, and then maybe for all.

## Testing
# for testing, I will use Mockito library;
# recommended coverage level is > 75.0%

# when generating mocks using @GenerateMocks, if the classes are the same, it will create duplicates,
# just in different files. I still do not know how to handle that.