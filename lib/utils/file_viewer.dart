import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/components/custom_appbar.dart';

import 'custom_function_utils.dart';

class MaterialDetailView extends StatefulWidget {
  final String title;
  final String type;
  final String url;

  const MaterialDetailView({
    super.key,
    required this.title,
    required this.type,
    required this.url,
  });

  @override
  State<MaterialDetailView> createState() => _MaterialDetailViewState();
}

class _MaterialDetailViewState extends State<MaterialDetailView> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  AudioPlayer? _audioPlayer;

  String? _localPdfPath;

  late String mediaType;

  @override
  void initState() {
    super.initState();

    mediaType = widget.type == 'auto' ? getMediaTypeFromUrl(widget.url) : widget.type;

    if (mediaType == 'video') {
      if (isUnsupportedVideoFormat(widget.url)) {
        return;
      }

      _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url))
        ..initialize().then((_) {
          _chewieController = ChewieController(
            videoPlayerController: _videoController!,
            autoPlay: false,
            looping: false,
          );
          setState(() {});
        }).catchError((e) {
          debugPrint("Error initializing video: $e");
        });
    } else if (mediaType == 'audio') {
      _audioPlayer = AudioPlayer()..play(UrlSource(widget.url));
    } else if (mediaType == 'pdf') {
      downloadFile(widget.url, 'temp.pdf').then((path) {
        if (mounted) {
          setState(() {
            _localPdfPath = path;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    _audioPlayer?.dispose();
    super.dispose();
  }

  Widget _buildContent() {
    switch (mediaType) {
      case 'image':
        return InteractiveViewer(
          panEnabled: true,
          minScale: 1.0,
          maxScale: 4.0,
          child: Image.network(
            widget.url,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Failed to load image'));
            },
          ),
        );
      case 'pdf':
        if (_localPdfPath == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return PDFView(
          filePath: _localPdfPath,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: true,
          pageFling: true,
        );
      case 'video':
        if (isUnsupportedVideoFormat(widget.url)) {
          return  Center(
            child: CustomText(
              text: 'This video format is not supported on your device.',
              fontSize: 15.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: AppColors.red,
              textCase: TextCase.sentence,
            ),
          );
        }

        if (_chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized) {
          return Chewie(controller: _chewieController!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }

      case 'audio':
        return Center(
          child: Icon(Icons.audiotrack, size: 100.h, color: AppColors.themeColor),
        );
      default:
        return const Center(child: Text("Unsupported media type"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                CustomHeaderView(courseName: widget.title, moduleName: widget.type),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
