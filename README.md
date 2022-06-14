# To do list (Manabie)
Project use bloc architecture with business logic in bloc, DAO and presentation. App also uses `GetIt` for dependency injection and `SQLite` for database (via `sqflite` plugin)
## How to run the code
The project is quite small, so it's simple to run (just follow the official Flutter doc)
- Firstly, install all packages needed for opening app
```sh
flutter pub get
```

- Finally, run it with your destination device or simulator
```sh
flutter run
```

>Note: The project was written in Visual Studio Code, I have config the the needed file in `.vscode`, you can run the app by press `F5`

## How to run unit test case
App unit test have database test and business test. You can run all the unit test by:
```sh
flutter test test/unit_test
```
Or run seperately:
```sh
flutter test test/unit_test/database_test.dart
flutter test test/unit_test/business_test.dart
```

*Note you can run unit test with [`Make`](https://formulae.brew.sh/formula/make). Run one of the following commands:
```sh
make unit_test #run all the unittest cases
make db_test
make business_test
```