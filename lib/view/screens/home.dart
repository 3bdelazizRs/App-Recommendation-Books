import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recommend_book_app/provider/book_provider.dart';
import 'package:recommend_book_app/utils/colors.dart';
import 'package:recommend_book_app/utils/images.dart';
import 'package:recommend_book_app/view/screens/allbook_screen.dart';
import 'package:recommend_book_app/view/screens/detailsbook_screen.dart';
import 'package:recommend_book_app/view/screens/discover_screen.dart';
import 'package:recommend_book_app/view/widgets/customimagenetwork.dart';

import '../../data/model/books/books.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      backgroundColor: backgroundColor,
      body: SizedBox(
        height: 800.h,
        child: Stack(
          children: [
            Image.asset(Images.backgroundImage),
            Positioned(
              top: 71.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Container(
                      width: 339,
                      height: 41,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(Images.search),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 19, left: 5),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Search by name..."),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 360.w,
                      height: 301.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: "disc",
                                    child: Text(
                                      'Discover Popular',
                                      style: GoogleFonts.imFellGreatPrimerSc(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Hunt new books before other bookworms do it...',
                                    style: GoogleFonts.inter(
                                      fontSize: 10.sp,
                                      color: Colors.black.withOpacity(0.4),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 35.w,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DiscoverPopular()),
                                    );
                                  },
                                  child: Text(
                                    'See All',
                                    style: GoogleFonts.inter(
                                      fontSize: 10.sp,
                                      color: Colors.black.withOpacity(0.4),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          SizedBox(
                              height: 200.w,
                              child: FutureBuilder(
                                future: bookProvider.popularBook(context),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List? data = snapshot.data;
                                    return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: data!.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsBook(
                                                            bookTitle: data[
                                                                    index]
                                                                ["Book-Title"],
                                                            bookauther: data[
                                                                    index]
                                                                ["Book-Author"],
                                                            bookimage: data[
                                                                    index]
                                                                ["Image-URL-M"],
                                                            isban: data[index]
                                                                ["ISBN"],
                                                          )),
                                                );
                                              },
                                              child: SizedBox(
                                                width: 107.w,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.r)),
                                                      width: 107.w,
                                                      height: 140.h,
                                                      child: CustomNetworkImage(
                                                        url: data[index]
                                                            ["Image-URL-M"],
                                                      ),
                                                    ),
                                                    Text(
                                                      data[index]
                                                          ["Book-Author"],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 12.sp,
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      data[index]["Book-Title"],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 16.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: 'Newest',
                          child: Text(
                            'Newest',
                            style: GoogleFonts.imFellGreatPrimerSc(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AllBooks()),
                            );
                          },
                          child: Text(
                            'See All',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Container(
                      width: 383.w,
                      height: 240.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: FutureBuilder(
                        future: BookProvider()
                            .allBook(context, Random().nextInt(10), 10),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List<Datum>? books = snapshot.data;
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: books!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 27.h, horizontal: 15.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsBook(
                                                bookTitle:
                                                    books[index].bookTitle,
                                                bookauther:
                                                    books[index].bookAuthor,
                                                bookimage:
                                                    books[index].imageUrlM,
                                                    isban:  books[index].isbn,
                                                    )),
                                      );
                                    },
                                    child: SizedBox(
                                      width: 107.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.r)),
                                            width: 107.w,
                                            height: 140.h,
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
                                              color:
                                                  Colors.black.withOpacity(0.4),
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
                                );
                              });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyImageWidget extends StatefulWidget {
  final String imageUrl;

  const MyImageWidget({super.key, required this.imageUrl});

  @override
  _MyImageWidgetState createState() => _MyImageWidgetState();
}

class _MyImageWidgetState extends State<MyImageWidget> {
  late Image _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() {
    _image = Image.network(
      widget.imageUrl,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.2),
          ),
          child: const Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
              size: 40,
            ),
          ),
        );
      },
    );

    _image.image.resolve(ImageConfiguration.empty).addListener(
          ImageStreamListener(
            (_, __) {
              // Do something when the image is loaded, if needed.
            },
            onError: (_, __) {
              // Evict the object from the cache to retry to fetch it the next
              // time this widget is built.
              imageCache.evict(_image.image);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 107,
      height: 140,
      child: _image,
    );
  }
}
