import 'package:blogs_app/core/theme/app_pallet.dart';
import 'package:blogs_app/core/utils/calculate_reading_time.dart';
import 'package:blogs_app/core/utils/format_date.dart';
import 'package:blogs_app/features/blogs/domain/entities/blog_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogViewer extends StatelessWidget {
  static route(BlogEntity blog, int readTime) => MaterialPageRoute(
      builder: (context) => BlogViewer(
            blog: blog,
            readTime: readTime,
          ));
  final BlogEntity blog;
  final int readTime;
  const BlogViewer({super.key, required this.blog, required this.readTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog viewer page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Scrollbar(
          radius: const Radius.circular(10),
          thickness: 5,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1),
                ),
                const SizedBox(height: 20),
                Text(
                  'By ${blog.userName}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .5),
                ),
                const SizedBox(height: 12),
                Text(
                  '${formateDateByddMMYYY(blog.updatedAt)} . $readTime min',
                  style: const TextStyle(
                      color: AppPallete.greyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://pktjzelwrksxtdnaqvhv.supabase.co/storage/v1/object/sign/blog_images/2a4fcc20-205f-11f0-9a4e-577aad290057?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJibG9nX2ltYWdlcy8yYTRmY2MyMC0yMDVmLTExZjAtOWE0ZS01NzdhYWQyOTAwNTciLCJpYXQiOjE3NDU1MTc2MjIsImV4cCI6MTc0NjEyMjQyMn0.dzwhh7HUKPDvDKo-hA2udzWLyFax_sDMYyXu_hJQpo0',
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  blog.content,
                  style: const TextStyle(
                    fontSize: 18,
                    letterSpacing: .7,
                    height: 2,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
