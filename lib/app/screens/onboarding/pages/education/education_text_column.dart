import 'package:flutter/material.dart';

import '../../widgets/text_column.dart';

class EducationTextColumn extends StatelessWidget {
  const EducationTextColumn();

  @override
  Widget build(BuildContext context) {
    return const TextColumn(
      title: 'Keep learning',
      text:
          'connect you with a workplace culture that encourages employees to prioritize ongoing learning and improvement.',
    );
  }
}
