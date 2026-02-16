import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quest_hive/modules/profile/profile_controller.dart';

import '../auth/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller =
  Get.find<ProfileController>();
  final AuthController authController =
  Get.find<AuthController>();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF1A237E);

    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logoutDialog,
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async =>
            controller.refreshData(),
        child: SingleChildScrollView(
          physics:
          const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              /// Header
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(
                    vertical: 32),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius:
                  const BorderRadius.vertical(
                      bottom:
                      Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person,
                          size: 48,
                          color: primary),
                    ),
                    const SizedBox(height: 12),
                    Obx(() => Text(
                      controller.userEmail
                          .value,
                      style:
                      GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    )),
                    const SizedBox(height: 18),

                    /// Completed Count
                    Container(
                      padding:
                      const EdgeInsets.all(
                          14),
                      margin:
                      const EdgeInsets.symmetric(
                          horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(
                            14),
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [
                          const Icon(
                              Icons.quiz,
                              color: primary),
                          const SizedBox(
                              width: 8),
                          Obx(() => Text(
                            "${controller.totalSubmissions.value} Questionnaires Completed",
                            style: GoogleFonts
                                .poppins(
                              fontWeight:
                              FontWeight
                                  .w500,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// Submission history
              Padding(
                padding:
                const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Submission History",
                      style:
                      GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Obx(() {
                      if (controller
                          .submissions.isEmpty) {
                        return Center(
                          child: Padding(
                            padding:
                            const EdgeInsets
                                .all(32),
                            child: Column(
                              children: [
                                Icon(
                                    Icons.history,
                                    size: 64,
                                    color: Colors
                                        .grey[400]),
                                const SizedBox(
                                    height: 12),
                                Text(
                                  "No submissions yet",
                                  style:
                                  GoogleFonts
                                      .poppins(
                                    color: Colors
                                        .grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        itemCount:
                        controller.submissions
                            .length,
                        itemBuilder:
                            (context, index) {
                          final s = controller
                              .submissions[
                          index];

                          return Card(
                            elevation: 4,
                            margin:
                            const EdgeInsets
                                .only(
                                bottom:
                                12),
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  16),
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets
                                  .all(16),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons
                                            .check_circle,
                                        color:
                                        primary,
                                      ),
                                      const SizedBox(
                                          width:
                                          10),
                                      Expanded(
                                        child:
                                        Text(
                                          s.questionnaireName,
                                          style:
                                          GoogleFonts.poppins(
                                            fontWeight:
                                            FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                      height: 6),
                                  Text(
                                    DateFormat(
                                        'MMM dd, yyyy - hh:mm a')
                                        .format(s
                                        .submissionDate),
                                    style:
                                    GoogleFonts
                                        .poppins(
                                      fontSize:
                                      12,
                                      color: Colors
                                          .grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Logout"),
        content: const Text(
            "Are you sure you want to logout?"),
        actions: [
          TextButton(
              onPressed: Get.back,
              child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Get.back();
              authController.logout();
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
