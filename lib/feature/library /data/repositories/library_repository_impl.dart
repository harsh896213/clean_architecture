import 'package:fpdart/src/either.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/core/network/connection_checker.dart';
import 'package:pva/feature/library%20/data/datasources/library_datasource.dart';
import 'package:pva/feature/library%20/domain/entities/document.dart';
import 'package:pva/feature/library%20/domain/entities/frequently_asked_question.dart';
import 'package:pva/feature/library%20/domain/entities/library_entity.dart';
import 'package:pva/feature/library%20/domain/entities/resource.dart';
import 'package:pva/feature/library%20/domain/entities/video_info.dart';
import 'package:pva/feature/library%20/domain/repository/library_repository.dart';

class LibraryRepositoriesImpl implements LibraryRepository{
  final LibraryDataSource libraryDataSource;
  final ConnectionChecker connectionChecker;


  const LibraryRepositoriesImpl(this.libraryDataSource, this.connectionChecker);

  @override
  Future<Either<ApiError, LibraryEntity>> getLibraryData(int use) async{
      return Right(
        LibraryEntity(
          resources: [
            Resource(title: "Understanding Heat Health Basics1", desc: "A comprehensive guide to dhbchdsbc dcknsdcnb ckjjdscn cksdcjk dcndcn cjdcj cdncjd cdnjcnd cjndcnd ",
                author: "Dr Sarah William 2", documentType: ResourceType.article),
            Resource(title: "Pnderstanding Heat Health Basics 3", desc: "A comprehensive guide to dhbchdsbc dcknsdcnb ckjjdscn cksdcjk dcndcn cjdcj cdncjd cdnjcnd cjndcnd ",
                author: "Dr Sarah William", documentType: ResourceType.article),
            Resource(title: "Anderstanding Heat Health Basics 4", desc: "A comprehensive guide to dhbchdsbc dcknsdcnb ckjjdscn cksdcjk dcndcn cjdcj cdncjd cdnjcnd cjndcnd ",
                author: "Dr Sarah William", documentType: ResourceType.video, videoInfo: VideoInfo(duration: "12:00", thumbnail: "https://images.pexels.com/photos/1114690/pexels-photo-1114690.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", url: "http.video.com")),
            Resource(title: "Pnderstanding Heat Health Basics 5", desc: "A comprehensive guide to dhbchdsbc dcknsdcnb ckjjdscn cksdcjk dcndcn cjdcj cdncjd cdnjcnd cjndcnd ",
                author: "Dr Sarah William", documentType: ResourceType.article),
            Resource(title: "Qnderstanding Heat Health Basics 6", desc: "A comprehensive guide to dhbchdsbc dcknsdcnb ckjjdscn cksdcjk dcndcn cjdcj cdncjd cdnjcnd cjndcnd ",
                author: "Dr Sarah William", documentType: ResourceType.video, videoInfo: VideoInfo(duration: "12:00", thumbnail: "https://images.pexels.com/photos/1114690/pexels-photo-1114690.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", url: "http.video.com")),
          ],
          document: [
            DocumentEntity(title: "Exercise program schedule 1", desc: "Exercise program schedule1", docType: "Pdf", date: DateTime.now()),
            DocumentEntity(title: "Toxic program schedule 2", desc: "Exercise program schedule2", docType: "Pdf", date: DateTime.now()),
            DocumentEntity(title: "Apple program schedule 3", desc: "Exercise program schedule3", docType: "Pdf", date: DateTime.now()),
            DocumentEntity(title: "Orange program schedule 4", desc: "Exercise program schedule4", docType: "Pdf", date: DateTime.now()),
            DocumentEntity(title: "Ticker program schedule 5", desc: "Exercise program schedule5", docType: "Pdf", date: DateTime.now()),
          ],
          frequentlyAskedQuestion: [
            FrequentlyAskedQuestionEntity(title: "What are the warning sign of hear attack 1", desc: "This is the description text jbkdjbc djcjdb cnbjdbcj dncdbncjkdbn bncjdb jcjdb nkcdnbc dkncnkdbnckn dkncdnkc dcndkjnbc",),
            FrequentlyAskedQuestionEntity(title: "What are the warning sign of blood pressure 2", desc: "This is the description text jbkdjbc djcjdb cnbjdbcj dncdbncjkdbn bncjdb jcjdb nkcdnbc dkncnkdbnckn dkncdnkc dcndkjnbc",),
            FrequentlyAskedQuestionEntity(title: "What are the warning sign of fever 3", desc: "This is the description text jbkdjbc djcjdb cnbjdbcj dncdbncjkdbn bncjdb jcjdb nkcdnbc dkncnkdbnckn dkncdnkc dcndkjnbc",),
            FrequentlyAskedQuestionEntity(title: "What are the warning sign of res 4", desc: "This is the description text jbkdjbc djcjdb cnbjdbcj dncdbncjkdbn bncjdb jcjdb nkcdnbc dkncnkdbnckn dkncdnkc dcndkjnbc",),
            FrequentlyAskedQuestionEntity(title: "What are the warning sign of hear trail 5", desc: "This is the description text jbkdjbc djcjdb cnbjdbcj dncdbncjkdbn bncjdb jcjdb nkcdnbc dkncnkdbnckn dkncdnkc dcndkjnbc",),
          ]
        )
      );
    }
  }
