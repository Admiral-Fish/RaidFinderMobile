class PersonalInfo {
  List<int> _stats;
  int genderRatio;
  int ability1, ability2, abilityH;
  int formCount;
  int formStatIndex;
  bool included;

  PersonalInfo(List<int> stats, int genderRatio, int ability1, int ability2,
      int abilityH, int formCount, int formStatIndex, bool included) {
    _stats = stats;
    this.genderRatio = genderRatio;
    this.ability1 = ability1;
    this.ability2 = ability2;
    this.abilityH = abilityH;
    this.formCount = formCount;
    this.formStatIndex = formStatIndex;
    this.included = included;
  }

  int getStat(int index) => _stats[index];

  int getAbility(int ability) {
    if (ability == 0) {
      return ability1;
    }

    if (ability == 1) {
      return ability2;
    }

    return abilityH;
  }
}
