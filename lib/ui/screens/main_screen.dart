import 'package:buksam_flutter_practicum/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/all_blocs.dart';
import '../../core/utils/constants.dart';
import '../widgets/book_pages.dart';
import '../widgets/helper_buttons.dart';
import 'summary_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double summaryLength = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const ProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<GenerativeAiBloc, GenerativeAiStates>(
                  listener: (context, state) {
                    if (state is LoadedGenerativeAiState) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return SummaryScreen(book: state.book);
                          },
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingGenerativeAiState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is ErrorGenerativeAiState) {
                      return Center(
                        child: Text(state.message),
                      );
                    }

                    return const Center(
                      child: Text("Kitob Yuklang"),
                    );
                  },
                ),
              ),
              const BookPages(),
              Slider(
                value: summaryLength,
                min: 1,
                max: 3,
                divisions: 2,
                label: SummaryLength.values[summaryLength.toInt() - 1].name,
                onChanged: (value) {
                  setState(() {
                    summaryLength = value;
                  });
                },
              ),
              BlocBuilder<PdfToImageBloc, PdfToImageStates>(
                builder: (context, state) {
                  return HelperButtons(
                    firstButtonClick: () {
                      context.read<FilePickerBloc>().add(SelectFileEvent());
                    },
                    secondButtonClick: state is LoadedPdfToImageState
                        ? () {
                            context.read<GenerativeAiBloc>().add(
                                  SummarizeAiEvent(
                                    state.files,
                                    SummaryLength
                                        .values[summaryLength.toInt() - 1],
                                  ),
                                );
                          }
                        : null,
                    firstButtonLabel: "UPLOAD",
                    secondButtonLabel: "SEND",
                    firstIcon: Icons.cloud_upload,
                    secondIcon: Icons.send,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
