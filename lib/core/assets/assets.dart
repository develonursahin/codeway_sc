
import 'images.dart';

class Assets {
  Assets._();
  static Assets? _instace;
  static Assets get instance {
    if (_instace != null) return _instace!;
    _instace = Assets._();
    return _instace!;
  }

  final Images image = Images.instance;
}
