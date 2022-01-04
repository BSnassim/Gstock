
  class Emprunt{
    final int? id;
    final int composant;
    final int member;
    final DateTime date;

    Emprunt({
      this.id,
      required this.date,
      required this.member,
      required this.composant,
    });

    Map<String, dynamic> toMap(){
      return{
        'FK_composant' : composant,
        'FK_member' : member,
        'date' : date.toIso8601String(),
      };
    }

    @override
    String toString() {
      return 'Emprunt{composant : $composant, member : $member, date : $date}';
    }
  }