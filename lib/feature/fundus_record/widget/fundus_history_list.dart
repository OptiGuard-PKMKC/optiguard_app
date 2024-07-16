import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:optiguard/feature/fundus_capture/provider/fundus_history_provider.dart';
import 'package:optiguard/feature/fundus_record/widget/fundus_detail_page.dart';
import 'package:optiguard/feature/fundus_record/widget/fundus_list_option.dart';
import 'package:optiguard/shared/util/global.dart';

class FundusHistoryList extends ConsumerStatefulWidget {
  const FundusHistoryList({super.key});

  @override
  FundusHistoryListState createState() => FundusHistoryListState();
}

class FundusHistoryListState extends ConsumerState<FundusHistoryList> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    final fundusState = ref.watch(fundusHistoryNotifierProvider);

    return // List of fundus history
        Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          fundusState.when(
              loading: () => Center(
                    child: CircularProgressIndicator(),
                  ),
              loaded: (funduses) {
                if (funduses.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak ada data fundus',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return Column(
                  children: funduses.map((fundus) {
                    String date = DateTime.now().toString();
                    // Format the date to "day name, date"
                    String formattedDate = DateFormat('EEEE, d MMMM y', "id")
                        .format(DateTime.parse(fundus["createdAt"] as String) ??
                            DateTime.parse(date));
                    String formattedTime = DateFormat('HH:mm', "id").format(
                        DateTime.parse(fundus["createdAt"] as String) ??
                            DateTime.parse(date));

                    return Column(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => FundusDetailPage(
                                            condition:
                                                fundus['condition'] as String,
                                            image: File(
                                                fundus['imagePath'] as String),
                                            isVerified:
                                                fundus['verified'] as int == 1,
                                            date: DateTime.parse(
                                                fundus['createdAt'] as String),
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.file(
                                              File(fundus['imagePath']
                                                  as String),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'TERINDIKASI',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Text(
                                                getConditionName(
                                                    fundus['condition']
                                                        as String),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                formattedDate,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              Text(
                                                formattedTime,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        shape: BoxShape.circle,
                                      ),
                                      child:
                                          const Icon(Icons.more_horiz_rounded),
                                    ),
                                    onPressed: () {
                                      final List<BottomSheetOption> options = [
                                        BottomSheetOption(
                                          title: 'Minta Verifikasi',
                                          icon: Icon(Icons.verified_rounded),
                                          onTap: () {
                                            print('Option 1 selected');
                                            // Implement your logic for Option 1
                                          },
                                        ),
                                        BottomSheetOption(
                                          title: 'Hapus',
                                          icon: Icon(Icons.delete_rounded),
                                          onTap: () {
                                            print('Option 2 selected');
                                            // Implement your logic for Option 2
                                            final fundusNotifier = ref.read(fundusHistoryNotifierProvider.notifier);
                                            fundusNotifier.deleteImage(fundus['id'] as int);
                                          },
                                        ),
                                      ];
                                      buildBottomSheetOption(context, options);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                );
              },
              error: (error) => Center(
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ))
        ],
      ),
    );
  }
}
