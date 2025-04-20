import 'package:blogs_app/core/theme/app_pallet.dart';
import 'package:blogs_app/features/blogs/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddNewBlogPage(),
      );
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> topics = [];

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add New Blog')),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DottedBorder(
                color: AppPallete.borderColor,
                dashPattern: const [10, 4],
                radius: const Radius.circular(12),
                borderType: BorderType.RRect,
                strokeCap: StrokeCap.round,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_open_rounded,
                        size: 40,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Select your image',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology',
                    'Business',
                    'Programming',
                    'Entertainment',
                  ]
                      .map(
                        (tag) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              if (topics.contains(tag)) {
                                topics.remove(tag);
                              } else {
                                topics.add(tag);
                              }
                              setState(() {});
                            },
                            child: Chip(
                              label: Text(tag),
                              color: topics.contains(tag)
                                  ? const WidgetStatePropertyAll(
                                      AppPallete.gradient1)
                                  : null,
                              side: BorderSide(
                                color: topics.contains(tag)
                                    ? AppPallete.gradient1
                                    : AppPallete.borderColor,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              BlogEditor(controller: titleController, hintText: 'Blog title'),
              const SizedBox(
                height: 12,
              ),
              BlogEditor(
                  controller: contentController, hintText: 'Blog content'),
              const SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
