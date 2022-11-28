void main() {
  // Cannot create instance with abstract class
  // final shape = Shape();
}

class PointWithoutEquality {
  final double x;
  final double y;

  PointWithoutEquality(this.x, this.y);
}

class PointWitEquality {
  final double x;
  final double y;

  PointWitEquality(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (other is PointWitEquality) {
      return x == other.x && y == other.y;
    }
    return false;
  }
}
