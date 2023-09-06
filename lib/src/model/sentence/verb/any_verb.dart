abstract class AnyVerb {
  bool get isTransitive;
  bool get isDitransitive;
  bool get isLinkingVerb;
  String get infinitive;
  String get presentParticiple;
  String get pastParticiple;

  String present({
    bool singularFirstPerson = true,
    bool singularThirdPerson = false,
    bool enableContraction = true,
    bool negative = false,
    bool alternativeContraction = false,
  });

  String simplePast({
    bool singularFirstPerson = true,
    bool singularThirdPerson = false,
    bool enableContraction = true,
    bool negative = false,
  });
}
