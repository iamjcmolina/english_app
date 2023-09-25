enum AdverbType {
  manner('Manner'),
  place('Place'),
  time('Time'),
  duration('Duration'),
  frequency('Frequency'),
  degree('Degree'),
  focusing('Focusing'),
  certainty('Certainty'),
  viewpoint('Viewpoint'),
  evaluative('Evaluative');

  final String name;

  const AdverbType(this.name);
}
