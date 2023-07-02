import 'package:flutter/material.dart';

import '../../model/clause/independent_clause.dart';

class FirstAuxVerb extends StatelessWidget {
  final IndependentClause clause;

  FirstAuxVerb({super.key, required this.clause});

  @override
  Widget build(BuildContext context) {
    return clause.firstAuxiliar == null? const SizedBox.shrink() : ListTile(
      title: Text(clause.firstAuxiliar!),
      subtitle: Text('First Auxiliar verb'
          '${
          clause.enableModalVerb ? ', Modal Verb'
              : clause.validVerb.isBe ? ', Verb "To BE"'
              : ''
          }'
      ),
      dense: true,
      trailing: clause.enableModalVerb ?
      const Icon(Icons.arrow_forward_ios)
          : const Icon(Icons.edit),
      onTap: clause.enableModalVerb? () {
      } : null,
    );
  }
}
