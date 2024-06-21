import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recommend_book_app/provider/book_provider.dart';
import 'package:recommend_book_app/view/screens/detailsbook_screen.dart';
import 'package:recommend_book_app/view/widgets/customimagenetwork.dart';

class DiscoverPopular extends StatefulWidget {
  const DiscoverPopular({super.key});

  @override
  State<DiscoverPopular> createState() => _DiscoverPopularState();
}

class _DiscoverPopularState extends State<DiscoverPopular> {
  late BookProvider bookProvider;

  @override
  void initState() {
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
      appBar: AppBar(
        title: Hero(
          tag: 'disc',
          child: Text(
            'Discover Popular',
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
        future: bookProvider.popularBook(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List? data = snapshot.data;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing:
                      20.h, // Changed to 20 for better spacing
                  crossAxisSpacing: 10, // Added crossAxisSpacing
                  childAspectRatio:
                      0.6, // Adjusted childAspectRatio for better layout
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsBook(
                                  bookTitle: data[index]["Book-Title"],
                                  bookauther: data[index]
                                      ["Book-Author"],
                                  bookimage: data[index]
                                      ["Image-URL-M"], isban:data[index]
                                      ["ISBN"] ,)),
                        );
                      },
                      child: SizedBox(
                        width: 107.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(5.r)),
                              width: 107.w,
                              height: 140.h,
                              child: CustomNetworkImage(
                                url: data![index]["Image-URL-M"],
                              ),
                            ),
                            Text(
                              data[index]["Book-Author"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Colors.black.withOpacity(0.4),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              data[index]["Book-Title"],
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
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
