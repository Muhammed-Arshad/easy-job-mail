import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmail/provider/home_provider/home_provider.dart';

import '../../../provider/home_provider/file_provider.dart';

class AttachmentsView extends ConsumerWidget {
  const AttachmentsView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final files = ref.watch(fileProvider);
    final selectedFile = ref.watch(selectedFileProvider);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: files.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3.5,
          crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        final file = files[index];
        return GestureDetector(
          onTap: (){
            ref.read(selectedFileProvider.notifier).state = index;
          },
          child: Card(
            color: selectedFile == index?Colors.blue:Colors.white,
            shadowColor: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(file.name!.substring(0,14),
                    style: const TextStyle(fontSize: 13),),
                  IconButton(onPressed: (){

                    ref.read(fileProvider.notifier)
                        .removeFile(file.path!);

                  }, icon: const Icon(Icons.close,size: 20,)),
                ], //just for testing, will fill with image later
              ),
            ),
          ),
        );
      },
    );
  }
}
