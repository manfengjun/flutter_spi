# Flutter Spi

A Dio NetWork plugin

## How to Use

```yaml
# add this line to your dependencies
flutter_spi: ^0.1.1
```

## Import

```dart
import 'package:flutter_spi/flutter_spi.dart';
```

## RxDart Extension

```dart
extension PGSpiRx on PGSpi {
  // object stream
  Stream<T> mapSpiObject<T>({String path}) => this
      .responseSpiJson(path: path)
      .asStream()
      .map((value) => BaseBeanEntity.fromJson(value).object<T>());
  // objects stream
  Stream<List<T>> mapSpiObjects<T>({String path}) => this
      .responseSpiJsons(path: path)
      .asStream()
      .map((value) => BaseBeanEntity.fromJsonList(value).objects<T>());
}
```

## Bean

```dart
class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "News") {
      return News.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
```

## Example

```dart
PGSpi(AccountAPI.login(
            {
                "type": "top",
                "key": "8093f06289133b469be6ff7ab6af1aa9"
            }
        )
    )
    .mapSpiObjects<News>(path: "data")
    .listen(
        (value) => print(value[0].authorName),
        onError: (e) {
            print((e.error as PGSpiError).message);
      },
    );
```

| class           | description          |
| --------------- | -------------------- |
| pg_spi          | Spi                  |
| pg_spi_dio      | Dio Response Convert |
| pg_spi_error    | Error                |
| pg_spi_logger   | Logger               |
| pg_spi_manager  | NetWork Manage       |
| pg_spi_response | Response Convert     |
| pg_spi_target   | Api Enum             |

## License

MIT License
