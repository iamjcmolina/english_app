import '../../nullable.dart';
import '../adverb/any_adverb.dart';
import '../noun/direct_object.dart';
import '../noun/indirect_object.dart';
import '../noun/subject.dart';
import '../noun/subject_complement.dart';
import '../verb/any_verb.dart';
import '../verb/modal_verb.dart';
import 'independent_clause_options.dart';

class IndependentClause {
  IndependentClauseOptions options;
  List<AnyAdverb> frontAdverbs;
  Subject? subject;
  ModalVerb? modalVerb;
  AnyAdverb? midAdverb;
  AnyVerb? verb;
  IndirectObject? indirectObject;
  DirectObject? directObject;
  SubjectComplement? subjectComplement;
  List<AnyAdverb> endAdverbs;

  IndependentClause({
    this.options = const IndependentClauseOptions(),
    this.frontAdverbs = const [],
    this.subject,
    this.modalVerb,
    this.midAdverb,
    this.verb,
    this.indirectObject,
    this.directObject,
    this.subjectComplement,
    this.endAdverbs = const [],
  });

  IndependentClause copyWith({
    IndependentClauseOptions? options,
    List<AnyAdverb>? frontAdverbs,
    Nullable<Subject>? subject,
    Nullable<ModalVerb>? modalVerb,
    Nullable<AnyAdverb>? midAdverb,
    Nullable<AnyVerb>? verb,
    Nullable<IndirectObject>? indirectObject,
    Nullable<DirectObject>? directObject,
    Nullable<SubjectComplement>? subjectComplement,
    List<AnyAdverb>? endAdverbs,
  }) => IndependentClause(
    options: options ?? this.options,
    frontAdverbs: frontAdverbs ?? this.frontAdverbs,
    subject: subject == null? this.subject : subject.value,
    modalVerb: modalVerb == null? this.modalVerb : modalVerb.value,
    midAdverb: midAdverb == null? this.midAdverb : midAdverb.value,
    verb: verb == null? this.verb: verb.value,
    indirectObject: indirectObject == null? this.indirectObject: indirectObject.value,
    directObject: directObject == null? this.directObject : directObject.value,
    subjectComplement: subjectComplement == null? this.subjectComplement: subjectComplement.value,
    endAdverbs: endAdverbs ?? this.endAdverbs,
  );
}
