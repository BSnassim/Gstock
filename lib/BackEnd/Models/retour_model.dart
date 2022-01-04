

  class Retour {
    final int? id;
    final int composant;
    final int member;
    final DateTime date;
    final String etat;

    Retour({
      this.id,
      required this.composant,
      required this.member,
      required this.date,
      required this.etat,
    });

    Map<String, dynamic> toMap(){
      return{
        'FK_composant' : composant,
        'FK_member' : member,
        'date' : date.toIso8601String(),
        'etat' : etat,
      };
    }

    @override
    String toString() {
      return 'Retour{composant : $composant, member : $member, date : $date, etat : $etat}';
    }
  }