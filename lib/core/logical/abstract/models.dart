import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;

class Pair<T, S> {
  final T? first;
  final S? second;
  Pair(this.first, this.second);
}

mixin Serializer {
  Map<String, dynamic> toJson();
  void reset();
}
