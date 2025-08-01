import 'dart:io';

import 'package:e_learning/api_service/api_service_url.dart';
import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_container.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/utils/file_viewer.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:e_learning/utils/video_thumbnail_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/study_material/study_material_provider.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/study_material/widget/study_material_params.dart';

class TopicDetailView extends HookConsumerWidget {
  final String topicId;
  final String topicName;
  const TopicDetailView({super.key, required this.topicId, required this.topicName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = useTextEditingController();
    final studyMaterialValue = ref.watch(
      studyMaterialProvider(StudyMaterialParams(topicId: topicId)),
    );
    final filteredData = useState<List<dynamic>>([]);

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(enableTheming: false),
          body: Column(
            children: [
              CustomHeaderView(
                courseName: "Study Material",
                moduleName: topicName,
              ),
              Expanded(
                child: studyMaterialValue.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                  data: (data) {
                    useEffect(() {
                      void listener() {
                        final query = searchText.text.toLowerCase();
                        if (query.isEmpty) {
                          filteredData.value = data;
                        } else {
                          filteredData.value = data.where((item) {
                            final title = item.materialTitle?.toLowerCase() ?? '';
                            final description = item.description?.toLowerCase() ?? '';
                            return title.contains(query) || description.contains(query);
                          }).toList();
                        }
                      }


                      searchText.addListener(listener);
                      filteredData.value = data;
                      return () => searchText.removeListener(listener);
                    }, [searchText, data]);

                    if (data.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(height: 20.h),
                          Image.asset(ImgAssets.noMaterial, width: 300.sp, height: 300.sp),
                          CustomText(
                            fontSize: 20.sp,
                            text: "No “Study Material” \n added yet",
                            textAlign: TextAlign.center,
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.w600,
                            textCase: TextCase.title,
                          ),
                        ],
                      );
                    }

                    final displayData = searchText.text.isEmpty ? data : filteredData.value;
                    final topicDescription = data.first.topicDescription ?? 'No Description';

                    final videoItems = displayData.where((e) => e.materialTypeName?.toLowerCase() == 'video').toList();
                    final readingItems = displayData.where((e) => e.materialTypeName?.toLowerCase() == 'reading').toList();
                    final imageItems = displayData.where((e) => e.materialTypeName?.toLowerCase() == 'images').toList();
                    final audioItems = displayData.where((e) => e.materialTypeName?.toLowerCase() == 'audio').toList();

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.sp, 5.sp, 15.sp, 10.sp),
                          child: SizedBox(
                            height: 40.h,
                            child: CustomTextField(
                              controller: searchText,
                              label: 'Search',
                              suffixIcon: Icon(Icons.search, color: AppColors.themeColor),
                            ),
                          ),
                        ),
                        if (displayData.isEmpty)
                          Expanded(
                            child: Center(
                              child: CustomText(
                                text: "No results found.",
                                fontSize: 18.sp,
                                color: AppColors.textGrey,
                                fontWeight: FontWeight.w500,
                                textCase: TextCase.title,
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15.sp, 5.sp, 15.sp, 10.sp),
                                    child: CustomText(
                                      text: data[0].topicName.toString(),
                                      fontSize: 18.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.themeColor,
                                      textCase: TextCase.title,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15.sp, 0.sp, 15.sp, 5.sp),
                                    child: CustomText(
                                      text: topicDescription,
                                      fontSize: 16.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textGrey,
                                      textCase: TextCase.sentence,
                                    ),
                                  ),
                                  if (videoItems.isNotEmpty) buildSection("Videos", videoItems, 'video'),
                                  if (readingItems.isNotEmpty) buildSection("Reading", readingItems, 'pdf'),
                                  if (imageItems.isNotEmpty) buildSection("Images", imageItems, 'image'),
                                  if (audioItems.isNotEmpty) buildSection("Audio", audioItems, 'audio'),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(String title, List<dynamic> items, String type) {
    return Padding(
      padding: EdgeInsets.only(left: 15.sp, top: 15.sp, bottom: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomContainer(
            borderRadius: 5.sp,
            innerPadding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
            padding: 0,
            text: title,
            textColor: AppColors.themeColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            containerColor: AppColors.lightBlueBackground,
            textCase: TextCase.title,
          ),
          SizedBox(height: 15.sp),
          SizedBox(
            height: 320.sp,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: 15.sp),
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(width: 10.sp),
              itemBuilder: (context, index) {
                final item = items[index];
                return buildCard(item, type);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(dynamic item, String type) {
    final String? videoPath =
    item.image != null ? '${ApiServiceUrl.urlLauncher}StudyMaterial/${item.image!}' : null;

    return FutureBuilder<String?>(
      future: (type == 'video' && videoPath != null)
          ? VideoThumbnailGenerator.generateThumbnail(videoPath)
          : Future.value(null),
      builder: (context, snapshot) {
        final thumbnailPath = snapshot.data;

        return InkWell(
          onTap: () {
            final fileUrl = '${ApiServiceUrl.urlLauncher}StudyMaterial/${item.image!}';
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MaterialDetailView(
                  title: item.materialTitle ?? 'Material',
                  type: type,
                  url: fileUrl,
                ),
              ),
            );
          },
          child: SizedBox(
            width: 280.sp,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.themeColor, width: 1.sp),
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.sp),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.sp),
                      child: Builder(
                        builder: (_) {
                          if (type == 'image' && videoPath != null) {
                            return Image.network(
                              videoPath,
                              height: 120.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          } else if (type == 'video' && thumbnailPath != null) {
                            return Stack(
                              children: [
                                Image.file(
                                  File(thumbnailPath),
                                  height: 120.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.play_circle_outline,
                                      color: Colors.white,
                                      size: 40.sp,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container(
                              height: 120.h,
                              width: double.infinity,
                              color: AppColors.lightBlueBackground,
                              child: Center(
                                child: Icon(
                                  type == 'audio'
                                      ? Icons.audio_file
                                      : type == 'pdf'
                                      ? Icons.picture_as_pdf
                                      : Icons.insert_drive_file,
                                  size: 60.h,
                                  color: AppColors.themeColor,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: item.materialTitle ?? 'No Title',
                          fontSize: 15.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          color: AppColors.themeColor,
                          textCase: TextCase.title,
                          maxLines: 2,
                        ),
                        SizedBox(height: 4.sp),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Definition: ',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              TextSpan(
                                text: item.description ?? '',
                                style: TextStyle(
                                  color: AppColors.textGrey,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Published: ${item.createdDate ?? 'N/A'}',
                          style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                        ),
                        SizedBox(height: 10.sp),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
