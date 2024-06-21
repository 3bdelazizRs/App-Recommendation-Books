import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recommend_book_app/data/model/bookRecommendation/BookRecommendation.dart';
import 'package:recommend_book_app/data/model/comment/get_comment_model.dart';
import 'package:recommend_book_app/utils/colors.dart';
import 'package:recommend_book_app/utils/images.dart';
import 'package:recommend_book_app/view/widgets/TimeDifferenceWidget.dart';
import 'package:recommend_book_app/view/widgets/customimagenetwork.dart';
import 'package:recommend_book_app/view/widgets/extention/widget_extension.dart';
import 'package:share_plus/share_plus.dart';
import '../../provider/book_provider.dart';

class DetailsBook extends StatefulWidget {
  const DetailsBook({
    super.key,
    required this.bookTitle,
    required this.bookauther,
    required this.bookimage,
    required this.isban,
  });
  final String bookTitle;
  final String bookauther;
  final String bookimage;
  final String isban;

  @override
  State<DetailsBook> createState() => _DetailsBookState();
}

class _DetailsBookState extends State<DetailsBook> {
  late BookProvider bookProvider;
  List<BookRecommendation>? recommendBook = [];

  getRecommendBook() async {
    recommendBook =
        await BookProvider().recommendBook(context, widget.bookTitle);
    setState(() {});
  }

  @override
  void initState() {
    getRecommendBook();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize bookProvider here to avoid the error
    bookProvider = Provider.of<BookProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 183.w,
              height: 271.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CustomNetworkImage(
                  url: widget.bookimage,
                ),
              ),
            ),
            Text(
              widget.bookTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              widget.bookauther,
              style: GoogleFonts.poppins(
                color: Colors.black.withOpacity(0.4),
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 200.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  circleBox(
                    onTap: () {},
                    child: SvgPicture.asset(Images.bookmark),
                  ),
                  circleBox(
                    onTap: () async {
                      await Share.share(
                          '${widget.bookTitle} \n${widget.bookimage}');
                    },
                    child: SvgPicture.asset(Images.send),
                  ),
                  circleBox(
                    onTap: () {
                      _showCommentBottomSheet(
                          context, int.parse(widget.isban), bookProvider);
                    },
                    child: SvgPicture.asset(Images.chat),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: recommendBook == null
                    ? Container()
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing:
                              20.h, // Changed to 20 for better spacing
                          crossAxisSpacing: 10, // Added crossAxisSpacing
                          childAspectRatio:
                              0.6, // Adjusted childAspectRatio for better layout
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsBook(
                                            bookTitle:
                                                recommendBook![index].title,
                                            bookauther:
                                                recommendBook![index].author,
                                            bookimage:
                                                recommendBook![index].imageUrl,
                                            isban: recommendBook![index].isbn,
                                          )),
                                );
                              },
                              // Added margin for better spacing
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      width: 107.w,
                                      height: 136.h,
                                      child: CustomNetworkImage(
                                        url: recommendBook![index].imageUrl,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            8.h), // Added SizedBox for spacing
                                    Text(
                                      recommendBook![index].author,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Colors.black.withOpacity(0.4),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            4.h), // Added SizedBox for spacing
                                    Text(
                                      recommendBook![index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        itemCount: recommendBook!.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class circleBox extends StatelessWidget {
  const circleBox({
    super.key,
    required this.child,
    required this.onTap,
  });
  final Widget child;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      width: 35.w,
      height: 35.h,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          shape: BoxShape.circle),
      child: child,
    ).onPress(onTap);
  }

  void showCommentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController commentController = TextEditingController();
        return AlertDialog(
          title: const Text('Comments'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  hintText: 'Add a comment...',
                ),
              ),
              // Add more widgets for the comments list
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Post'),
              onPressed: () {
                // Handle the post comment action
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Widget _buildComment(String username, String comment) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Text('$username: ',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(comment),
      ],
    ),
  );
}

void _showCommentBottomSheet(
    BuildContext context, int idBook, BookProvider bookProvider) {
  TextEditingController commentController = TextEditingController();
  showModalBottomSheet(
    backgroundColor: backgroundColor,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Comments:'),
                const SizedBox(height: 8),
                SizedBox(
                    height: 450.h,
                    child: FutureBuilder(
                        future: bookProvider.getComment(context, idBook),
                        builder: (context, snapshot) {
                          List<Comment>? data = snapshot.data;
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.yellow,
                              ),
                            );
                          }

                          return ListView.builder(
                              itemCount: data!.length,
                              itemBuilder: (context, i) => Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: 342.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor: Colors.amber,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                data[i].author,
                                                style: GoogleFonts.inter(
                                                  fontSize: 13.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              TimeDifferenceWidget(
                                                  createdAt:
                                                      "${data[i].createdAt}")
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 45.w),
                                            child: Text(
                                              textAlign: TextAlign.justify,
                                              data[i].content,
                                              style: GoogleFonts.inter(
                                                fontSize: 10.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                        })),

                // Add a TextField for new comments
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100.r),
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
                    SizedBox(width: 10.w),
                    Container(
                      height: 40.h,
                      width: 40.w,
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
                    ).onPress(() {
                      bookProvider.addComment(
                          context,
                          idBook,
                          '${bookProvider.authModel.username}',
                          commentController.text);
                      commentController.clear();

                      bookProvider.getComment(context, idBook);
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
