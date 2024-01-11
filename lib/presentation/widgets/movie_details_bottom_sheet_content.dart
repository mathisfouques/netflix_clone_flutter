import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../domain/entities/movie_details.dart';
import '../../list_extension.dart';
import '../../nflx_theme.dart';

class MovieDetailsBottomSheetContent extends StatelessWidget {
  final MovieDetails details;

  const MovieDetailsBottomSheetContent({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: NflxColors.darkGrey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TrailerSection(),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: DetailsSection(details: details),
                  ),
                  const TabSection()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TrailerSection extends StatelessWidget {
  const TrailerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.amber,
    );
  }
}

class DetailsSection extends StatelessWidget {
  final MovieDetails details;

  const DetailsSection({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          details.title,
          style: NflxTypo.bold.toSize(24),
        ),
        const Gap(12),
        if (details.releaseYear != null) ...[
          Row(children: [
            if (DateTime.now().year == details.releaseYear)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Nouveau",
                  style: NflxTypo.regular.toColor(Colors.greenAccent),
                ),
              ),
            Text(
              details.releaseYear.toString(),
              style: NflxTypo.regular.toSize(18),
            ),
            const Gap(12),
            const Icon(
              Icons.abc,
              color: NflxColors.typoLight,
            ),
            const Gap(8),
            Text(
              details.duration.representation,
              style: NflxTypo.regular.toSize(18),
            ),
            const Gap(12),
            //TODO replace with correct images
            ...List.generate(
                3,
                (index) => const Icon(
                      Icons.abc,
                      color: NflxColors.typoLight,
                    ))
              ..spaced(const Gap(8))
          ]),
          const Gap(8)
        ],
        Row(
          children: [
            const Icon(Icons.abc),
            const Gap(8),
            Text(
              "N°1 des films aujourd'hui",
              style: NflxTypo.bold.toSize(22),
            )
          ],
        ),
        const Gap(12),
        ElevatedButton(
          style: NflxButton.primary,
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.arrowtriangle_right_fill,
                color: NflxColors.black,
              ),
              const Gap(8),
              Text(
                "Lecture",
                style: NflxTypo.bold.toColor(NflxColors.black).toSize(22),
              )
            ],
          ),
        ),
        const Gap(12),
        ElevatedButton(
          style: NflxButton.secondary,
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.arrow_down_to_line,
                color: NflxColors.typoLight,
              ),
              const Gap(8),
              Text(
                "Télécharger",
                style: NflxTypo.bold.toSize(22),
              )
            ],
          ),
        ),
        const Gap(16),
        Text(
          details.description,
          style: NflxTypo.regular.toSize(16),
          maxLines: 10,
        ),
        const Gap(12),
        Text(
          "Distribution : ${details.credits?.popularActors.join(', ')}",
          style: NflxTypo.regular.toSize(18).toColor(NflxColors.lightGrey),
        ),
        const Gap(8),
        Text(
          "Réalisateur : ${details.credits?.director}",
          style: NflxTypo.regular.toSize(18).toColor(NflxColors.lightGrey),
        ),
      ],
    );
  }
}

class TabSection extends StatefulWidget {
  const TabSection({super.key});

  @override
  State<TabSection> createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: TabController(length: 2, vsync: this),
      children: const [
        SimilarTabView(),
        TrailersTabView(),
      ],
    );
  }
}

class SimilarTabView extends StatelessWidget {
  const SimilarTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TrailersTabView extends StatelessWidget {
  const TrailersTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
