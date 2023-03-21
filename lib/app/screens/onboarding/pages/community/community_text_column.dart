import 'package:flutter/material.dart';

import '../../widgets/text_column.dart';

class CommunityTextColumn extends StatelessWidget {
  const CommunityTextColumn();

  @override
  Widget build(BuildContext context) {
    return const TextColumn(
      title: 'Community Jobs',
      text:
          'with a positive work environment we help you fosters strong team spirit and camaraderie, feel valued and appreciated ',
    );
  }
}
