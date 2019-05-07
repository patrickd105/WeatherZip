# WeatherZip

## Requirements

- Cocoapods 1.6.1
- Xcode 10.2 or greater

## Installation

1. Run `pod update` from Terminal in the WeatherZip directory
2. After the installation completes, open WeatherZip.xcworkspace in Xcode 10.2
3. Select an iOS Simulator of your choice for your run target
4. Click the "Run" button to run the application

## Architecture Highlights

**Model-View-Presenter Architecture**

* Most of this can be seen in the `ZipPresenter` and `ZipViewController` classes. Most of the business logic is isolated to the presenter so the ViewController can be kept as simple as possible. This also helps to increase the overall testability since unit testing ViewControllers is usually ineffective.
* There is loose coupling between `ZipPresenter` and `ZipViewController` thanks to the `ZipView` protocol, which leaves the UI specifics to the attached view.

**Single responsibility principle**

* `ZipManager` seems like an unnecessary wrapper around `ZipService`, but almost always there is a layer of parsing or caching that takes place before the presenter is given the data, so the service class can focus on only making the network calls while the manager can do handling of data that is now local. That way we can test logic in manager classes by making a service mock.

**Unit and UI Tests**

* `ZipPresenterTests` and `WeatherZipUITests` show basic `XCTest` usage. `ZipPresenterTests` specifically shows off how MVP architecture can help with unit testing efforts.

**External library usage**

* Cocoapods was set up with this repo to show usage of a common library known as `Kingfisher`, which will load remote images and has optional ways to show loading times to user

## Future Improvements

**Proper networking layer**

* It's important to have a consolidated network layer in case multiple sources try to fetch from the same endpoint. The networking call itself in `ZipService` could be much cleaner with a proper networking layer as well.

**A real account with the Destination Weather API**

* The keys used are for demo purposes and therefore could be rendered ineffective at any time. Please let me know if the API errors out for you and I will update the keys.

**Integration tests**

* To alleviate the unknowns with the Weather API, integration tests that actually hit the API could be run on a regular schedule and on the build pipeline. That way the team could be notified of an outage without wasting developer time with slower unit tests.

**Certificates and Profiles**

* So the app can be run on a real device instead of only simulators
