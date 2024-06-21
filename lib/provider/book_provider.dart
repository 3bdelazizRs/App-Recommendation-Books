import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recommend_book_app/data/db/shared-preferences.dart';
import 'package:recommend_book_app/data/model/auth_model/auth_model.dart';
import 'package:recommend_book_app/data/model/books/books.dart';
import 'package:recommend_book_app/data/model/comment/get_comment_model.dart';
import 'package:recommend_book_app/data/repository/api_repo.dart';
import 'package:recommend_book_app/view/screens/auth/login.dart';
import 'package:recommend_book_app/view/screens/navigation_bar.dart';
import '../data/model/bookRecommendation/BookRecommendation.dart';
import '../utils/api_url.dart';

class BookProvider extends ChangeNotifier {
  ApiRepo apiRepo = ApiRepo();

  Auth authModel = Auth();
  //=================================s Authentication APIs ===============================================

  bool isAuthloading = false;
  login(BuildContext context, String email, String password) async {
    isAuthloading = true;
    notifyListeners();
    dynamic data = {"email": email, "password": password};
    log("Email : $email , Password : $password");
    try {
      Response response =
          await apiRepo.postRequest(context, "", ApiUrl.login, data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data["status"] == true) {
          Auth auth = Auth.fromJson(response.data);
          LocalDb.storeUser(auth);
          notifyListeners();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const BtnNavigationBar()),
              (route) => false);
        }
      }
      isAuthloading = false;
      notifyListeners();
    } catch (e) {
      isAuthloading = false;
      notifyListeners();
      log("$e");
    }
  }

  register(BuildContext context, String username, String email,
      String password) async {
    FocusManager.instance.primaryFocus!.unfocus();
    dynamic data = {"username": username, "email": email, "password": password};
    isAuthloading = true;
    notifyListeners();
    log("Email : $email , Password : $password");
    try {
      Response response =
          await apiRepo.postRequest(context, "", ApiUrl.register, data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data["status"] == true) {
          Fluttertoast.showToast(
              msg: '${response.data["message"]}',
              backgroundColor: Colors.green);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
              (route) => false);
        }
      }
      isAuthloading = false;
      notifyListeners();
    } catch (e) {
      log("$e");
    }
  }

  logoutUser(BuildContext context) async {
    FocusManager.instance.primaryFocus!.unfocus();
    LocalDb.clearSharedPreferenceValue();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
  }

  //=================================s Books APIs ===============================================
  Future<List?> popularBook(BuildContext context) async {
    Response response = await apiRepo.getBookRequest(
      context,
      "",
      ApiUrl.popularBook,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List popularbook = response.data;

      return popularbook;
    } else {
      return null;
    }
  }

  Future<List<Datum>?> allBook(
      BuildContext context, int page, int perPage) async {
    dynamic data = {"page": page, "per_page": perPage};
    Response response =
        await apiRepo.postRequest(context, "", ApiUrl.allBook, data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Books booksData = Books.fromJson(response.data);
      List<Datum>? books = booksData.data;

      return books;
    } else {
      return null;
    }
  }

  Future<List<BookRecommendation>?> recommendBook(
      BuildContext context, String book) async {
    dynamic data = {"book": book};
    try {
      Response response =
          await apiRepo.postRequest(context, "", ApiUrl.recommend, data);
      log("${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> recommendationsJson = response.data;
        log("$recommendationsJson");
        return recommendationsJson
            .map((json) => BookRecommendation.fromJson(json))
            .toList();
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  // -------- Comments API -------------

  Future addComment(
      BuildContext context, int idBook, String author, String content) async {
    dynamic data = {"idBook": idBook, "author": author, "content": content};
    try {
      Response response =
          await apiRepo.postRequest(context, "", ApiUrl.comments, data);
      log("${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
            msg: "Comment added", backgroundColor: Colors.green);

        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: "Error", backgroundColor: Colors.red);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<Comment>?> getComment(BuildContext context, int idBook) async {
    dynamic data = {"idBook": idBook};
    try {
      Response response =
          await apiRepo.postRequest(context, "", ApiUrl.getComments, data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        GetComments comments = GetComments.fromJson(response.data);
        List<Comment> allComments = comments.comments;
        notifyListeners();
        return allComments;
      } else {
        Fluttertoast.showToast(msg: "Error", backgroundColor: Colors.red);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
