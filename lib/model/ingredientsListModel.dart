
class IngredientList{
  final String name;
  final String quantity;

  IngredientList(this.name, this.quantity);

  @override
  String toString() => '$name';

  String toStrings() => '$name - $quantity';
}