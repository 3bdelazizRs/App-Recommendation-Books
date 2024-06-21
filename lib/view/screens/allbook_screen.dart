import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recommend_book_app/data/model/books/books.dart';
import 'package:recommend_book_app/view/screens/detailsbook_screen.dart';

import '../../provider/book_provider.dart';
import '../widgets/customimagenetwork.dart';

class AllBooks extends StatelessWidget {
  const AllBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag:'Newest',
          child: Text(
                            'Newest',
                            style: GoogleFonts.imFellGreatPrimerSc(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
        ),
        elevation: 0,
        bottomOpacity: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: BookProvider().allBook(context, 1, 50),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Datum>? books = snapshot.data;
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20.h, // Changed to 20 for better spacing
                crossAxisSpacing: 10, // Added crossAxisSpacing
                childAspectRatio:
                    0.6, // Adjusted childAspectRatio for better layout
              ),
              itemBuilder: (context, index) => Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 27.h, horizontal: 15.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsBook(
                                  bookTitle: books[index].bookTitle,
                                  bookauther: books[index].bookAuthor,
                                  bookimage: books[index].imageUrlM,
                                  isban: books[index].isbn,
                                  )),
                        );
                      },
                      child: SizedBox(
                        width: 140.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r)),
                              width: 107.w,
                              height: 100.h,
                              child: CustomNetworkImage(
                                url: books[index].imageUrlL,
                              ),
                            ),
                            Text(
                              books[index].bookAuthor,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Colors.black.withOpacity(0.4),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              books[index].bookTitle,
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
                  ),
              itemCount: books!.length);
        },
      ),
    );
  }
}
