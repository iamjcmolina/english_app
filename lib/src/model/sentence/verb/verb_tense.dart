enum VerbTense {
  infinitive('Infinitive'),
  present('Present'),
  past('Past'),
  future('Future'),
  progressive('Progressive'),
  pastParticiple('Past Participle'),
  conditional('Conditional');

  final String name;

  const VerbTense(this.name);
}
