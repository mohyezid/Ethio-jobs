import 'package:flutter/material.dart';

import '../../widgets/text_column.dart';

class WorkTextColumn extends StatelessWidget {
  const WorkTextColumn();

  @override
  Widget build(BuildContext context) {
    return const TextColumn(
      title: 'Work together',
      text:
          'Collaboration in the workplace  and work together to achieve a common goal in ways that benefit you.',
    );
  }
}
