
  class Category{
    final int? id;
    final String name;

    Category({
      this.id,
      required this.name,
    });

    Map<String, dynamic> toMap(){
      return{
        'name' : name,
      };
    }

    @override
  String toString() {
    return 'Category{name : $name}';
  }
  }