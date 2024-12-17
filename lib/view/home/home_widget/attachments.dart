import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmail/provider/home_provider/home_provider.dart';

import '../../../provider/home_provider/file_provider.dart';

class AttachmentsView extends ConsumerWidget {
  const AttachmentsView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final files = ref.watch(fileProvider);
    
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: files.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3.5,
          crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        final file = files[index];
        return Card(
          color: Colors.white,
          shadowColor: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Text('Arshad'),
                Text(file.name!.substring(0,14)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.close)),
              ], //just for testing, will fill with image later
            ),
          ),
        );
      },
    );
  }
}
