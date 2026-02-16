import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest_hive/modules/questionnaires/questionnaires_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionnaireScreen extends StatelessWidget {
  final QuestionnaireController controller =
  Get.find<QuestionnaireController>();

  QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF1A237E);

    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),

      /// ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(
          'Questionnaire',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        actions: [
          Obx(() {
            if (controller.selectedAnswers.isEmpty) {
              return const SizedBox.shrink();
            }
            return IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () => _clearDialog(),
            );
          }),
        ],
      ),

      body: Column(
        children: [
          _draftBanner(primary),
          _headerSection(primary),
          _questionList(primary),
          _submitBar(primary),
        ],
      ),
    );
  }

  /// ================= DRAFT BANNER =================
  Widget _draftBanner(Color primary) {
    return Obx(() {
      if (controller.selectedAnswers.isEmpty) {
        return const SizedBox.shrink();
      }

      final restored = controller.isDraftRestored.value;

      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        color: restored ? Colors.blue[50] : Colors.green[50],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              restored ? Icons.restore : Icons.cloud_done,
              size: 14,
              color: restored ? Colors.blue : Colors.green,
            ),
            const SizedBox(width: 6),
            Text(
              restored
                  ? "Draft restored — Auto saving"
                  : "Answers auto-saved",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    });
  }

  /// ================= HEADER =================
  Widget _headerSection(Color primary) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: primary.withOpacity(0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.questionnaire.title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            controller.questionnaire.description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          Obx(() {
            final answered = controller.getAnsweredCount();
            final total = controller.getTotalQuestions();
            final percent = total == 0 ? 0 : answered / total;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "$answered / $total answered",
                      style: GoogleFonts.poppins(fontSize: 13),
                    ),
                    const Spacer(),
                    Text(
                      "${(percent * 100).toInt()}%",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: percent.toDouble(),
                    minHeight: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                    AlwaysStoppedAnimation(primary),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  /// ================= QUESTIONS =================
  Widget _questionList(Color primary) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount:
        controller.questionnaire.questions.length,
        itemBuilder: (context, index) {
          final q =
          controller.questionnaire.questions[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  /// Question Title
                  Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: primary,
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          q.questionText,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  /// Options
                  ...q.options.map((option) {
                    return Obx(() {
                      final selected =
                      controller.isAnswerSelected(
                          q.id, option);

                      return InkWell(
                        onTap: () => controller
                            .selectAnswer(
                            q.id, option),
                        borderRadius:
                        BorderRadius.circular(12),
                        child: Container(
                          margin:
                          const EdgeInsets.only(
                              bottom: 8),
                          padding:
                          const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: selected
                                ? primary
                                .withOpacity(0.08)
                                : Colors.grey[100],
                            borderRadius:
                            BorderRadius.circular(
                                12),
                            border: Border.all(
                              color: selected
                                  ? primary
                                  : Colors.grey[300]!,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selected
                                    ? Icons
                                    .radio_button_checked
                                    : Icons
                                    .radio_button_off,
                                color: selected
                                    ? primary
                                    : Colors.grey,
                              ),
                              const SizedBox(
                                  width: 10),
                              Expanded(
                                child: Text(
                                  option,
                                  style:
                                  GoogleFonts
                                      .poppins(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// ================= SUBMIT =================
  Widget _submitBar(Color primary) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black12,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: Obx(() {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.isSubmitting.value
                ? null
                : controller
                .submitQuestionnaire,
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              padding:
              const EdgeInsets.symmetric(
                  vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(14),
              ),
            ),
            child: controller.isSubmitting.value
                ? const SizedBox(
              height: 20,
              width: 20,
              child:
              CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : Text(
              "Submit Answers",
              style:
              GoogleFonts.poppins(
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),
        );
      }),
    );
  }

  /// ================= CLEAR DIALOG =================
  void _clearDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Clear Answers"),
        content: const Text(
            "Are you sure you want to delete draft answers?"),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.clearDraft();
            },
            child: const Text(
              "Clear",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
