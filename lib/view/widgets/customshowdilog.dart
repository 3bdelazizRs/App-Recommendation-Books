import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recommend_book_app/data/model/comment/get_comment_model.dart';
import 'package:recommend_book_app/provider/book_provider.dart';
import 'package:recommend_book_app/utils/images.dart';
import 'package:recommend_book_app/view/widgets/TimeDifferenceWidget.dart';
import 'package:recommend_book_app/view/widgets/extention/widget_extension.dart';

void _showCommentBottomSheet(
    BuildContext context, int idBook, BookProvider bookProvider) {
  
}

class CommentBottomSheet extends StatefulWidget {
  final int idBook;

  const CommentBottomSheet({super.key, required this.idBook});

  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BookProvider bookProvider = Provider.of<BookProvider>(context);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Comments:'),
            const SizedBox(height: 8),
            SizedBox(
              height: 450,
              child: FutureBuilder<List<Comment>?>(
                future: bookProvider.getComment(context, widget.idBook),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
                      ),
                    );
                  }

                  List<Comment> data = snapshot.data!;

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.amber,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  data[i].author,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                TimeDifferenceWidget(
                                  createdAt: "${data[i].createdAt}",
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 45),
                              child: Text(
                                textAlign: TextAlign.justify,
                                data[i].content,
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: TextFormField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Images.send,
                      color: Colors.white,
                    ),
                  ),
                ).onPress(() async {
                  await bookProvider.addComment(
                    context,
                    widget.idBook,
                    '${bookProvider.authModel.username}',
                    commentController.text,
                  );
                  commentController.clear();

                  setState(() {
                    // This will trigger the FutureBuilder to refetch the comments
                  });
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
