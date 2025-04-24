import 'package:blogs_app/core/utils/calculate_reading_time.dart';
import 'package:blogs_app/features/blogs/domain/entities/blog_entity.dart';
import 'package:blogs_app/features/blogs/presentation/pages/blog_viewer.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final BlogEntity blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    final calculatedTime = calculateReadingTime(blog.content);
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, BlogViewer.route(blog, calculatedTime)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(12),
        height: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: blog.topicTags
                        .map(
                          (tag) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 2),
                            child: Chip(
                              label: Text(tag),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            Text('${calculateReadingTime(blog.content).toString()} min'),
          ],
        ),
      ),
    );
  }
}
