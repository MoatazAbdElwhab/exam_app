// features/explore/presentation/pages/explore_page.dart

// features/explore/presentation/pages/explore_page.dart
import 'package:exam_app/core/di/injectable.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/routes/routes.dart';

import 'package:exam_app/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:exam_app/features/explore/presentation/widget/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  void dispose() {
    // exploreCubit.close();
    super.dispose();
  }

  final exploreCubit = getIt.get<ExploreCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => exploreCubit,
      // value: exploreCubit,
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: BlocBuilder<ExploreCubit, ExploreState>(
          buildWhen: (previous, current) {
            if (current is GetSubjetcsFail ||
                current is GetSubjetcsLoading ||
                current is GetSubjetcsSuccess) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            switch (state) {
              case GetSubjetcsLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case GetSubjetcsFail():
                return Center(
                  child: Text(state.errorMsg),
                );
              case GetSubjetcsSuccess():
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //text surveys
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 56.h),
                          Text(
                            'Surveys',
                            style: getMediumStyle(
                              color: ColorManager.blue,
                              fontSize: 22.sp,
                            ),
                          ),

                          //search textfield and icon
                          SizedBox(height: 16.h),

                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 24,
                              ),
                              hintText: 'Search',
                              hintStyle: getMediumStyle(
                                color: ColorManager.grey,
                                fontSize: 14.sp,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),

                          //browse by subject
                          SizedBox(height: 30.h),
                          Text(
                            "Browse by Subject",
                            style: getMediumStyle(
                              color: ColorManager.black,
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //listview of subjects
                    SizedBox(height: 12.h),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        itemCount: state.subjects.length,
                        // clipBehavior: Clip.none,
                        itemBuilder: (context, index) {
                          final subject = state.subjects[index];
                          return GestureDetector(
                            onTap: () {
                              exploreCubit.getAllExamOnSubject(subject.id);
                              Navigator.of(context).pushNamed(
                                Routes.exams,
                                arguments: ExamData(
                                  subjectID: subject.id,
                                  subjectName: subject.name,
                                  exploreCubit: exploreCubit,
                                ),
                              );
                            },
                            child: SubjectCard(
                              iconUrl: subject.icon,
                              title: subject.name,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class ExamData {
  final String subjectID;
  final String subjectName;
  final ExploreCubit exploreCubit;

  ExamData({
    required this.subjectID,
    required this.subjectName,
    required this.exploreCubit,
  });
}
