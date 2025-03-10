import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/UI/Exercises/exercise_details_header_widget.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/exercise_progress_repository.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Exercises/exercise_task_checkbox.dart';
import 'package:jak_sie_masz/UI/Exercises/reset_exercise_buttton_widget.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/exercise_task_checkbox_viewmodel.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/exercises_viewmodel.dart';
import 'package:jak_sie_masz/UI/Exercises/viewmodels/reset_exercise_button_viewmodel.dart';
import 'package:provider/provider.dart';

class ExercisesDetailsScreen extends StatelessWidget {
  final ExerciseProgressRepository repository;
  final List<ExerciseTaskCheckbox> checkboxes = [];
  ExercisesDetailsScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExercisesViewModel>(
      builder: (context, viewModel, child) {
        final exercise = viewModel.selectedExercise;
        repository.reserveSpace(exercise.id, exercise.tasks.length);
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                key: Key("title"),
                height: 300,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      exercise.pathToImage,
                      fit: BoxFit.cover,
                      color: Styles.primaryColor500.withAlpha(178),
                      colorBlendMode: BlendMode.srcOver,
                    ),
                    Center(
                      child: Text(
                        exercise.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: Styles.fontFamily,
                          fontSize: Styles.fontSizeH1,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 32,
                      left: 20,
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: SvgPicture.asset(
                          "assets/icons/arrow-left.svg",
                          width: 24,
                          height: 24,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Styles.exerciseDetailsBgColor,
                child: Container(
                  transform: Matrix4.translation(math.Vector3(0, -32, 0)),
                  decoration: BoxDecoration(
                      color: Styles.exerciseDetailsBgColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Styles.fontColorDark.withAlpha(64),
                          blurRadius: 32,
                          offset: Offset(0, -24),
                          spreadRadius: 0,
                        )
                      ]),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 16,
                    children: [
                      ExerciseDetailsHeaderWidget(title: "Opis"),
                      Text(
                        exercise.description,
                        style: TextStyle(
                          fontFamily: Styles.fontFamily,
                          fontWeight: FontWeight.w300,
                          color: Styles.fontColorDark,
                          fontSize: Styles.fontSizeP,
                          decoration: TextDecoration.none,
                          letterSpacing: 0.2,
                          height: 1.25,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ExerciseDetailsHeaderWidget(title: "Zadania"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: List.generate(exercise.tasks.length, (index) {
                          ExerciseTaskCheckbox checkbox = ExerciseTaskCheckbox(
                            viewmodel: ExerciseTaskCheckboxViewmodel(
                                repository: repository,
                                exerciseID: exercise.id,
                                taskID: index),
                          );

                          checkboxes.add(checkbox);

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  exercise.tasks[index],
                                  style: TextStyle(
                                    fontFamily: Styles.fontFamily,
                                    fontWeight: FontWeight.normal,
                                    fontSize: Styles.fontSizeP,
                                    color: Styles.fontColorDark,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: checkbox,
                              ),
                            ],
                          );
                        }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        alignment: Alignment.center,
                        child: ResetExerciseButtton(
                            viewmodel: ResetExerciseButtonViewmodel(
                                repository: repository, checkboxes: checkboxes),
                            exerciseID: exercise.id,
                            tasksCount: exercise.tasks.length),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ExerciseDetailsHeaderWidget(
                          title: "Dla zainteresowanych"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(exercise.links.length, (index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  exercise.links[index],
                                  style: TextStyle(
                                    fontFamily: Styles.fontFamily,
                                    fontSize: Styles.fontSizeP,
                                    fontWeight: FontWeight.normal,
                                    color: Styles.fontColorDark,
                                    decoration: TextDecoration.none,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child:
                                    SvgPicture.asset("assets/icons/link.svg"),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
