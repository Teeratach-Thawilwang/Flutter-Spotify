import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify/core/constants/app_images.dart';
import 'package:spotify/core/constants/app_vectors.dart';
import 'package:spotify/core/theme/app_colors.dart';
import 'package:spotify/common/extensions/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/features/song/presentation/bloc/new_songs_cubit.dart';
import 'package:spotify/features/song/presentation/bloc/new_songs_state.dart';
import 'package:spotify/features/song/presentation/bloc/play_list_cubit.dart';
import 'package:spotify/features/song/presentation/bloc/play_list_state.dart';
import 'package:spotify/features/song/presentation/widgets/news_songs.dart';
import 'package:spotify/features/song/presentation/widgets/play_list.dart';
import 'package:spotify/route/route_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isNewSongsLoading = true;
  bool isPlayListLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? Color(0xff1C1B1B) : null,
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => NewSongsCubit()..getNewsSongsStream()),
            BlocProvider(
              create: (context) => PlayListCubit()..getPlayListStream(),
            ),
          ],
          child: BlocListener<NewSongsCubit, NewSongsState>(
            listener: (context, state) {
              if (state is NewSongsLoaded) {
                setState(() {
                  isNewSongsLoading = false;
                });
              }
            },
            child: BlocListener<PlayListCubit, PlayListState>(
              listener: (context, state) {
                if (state is PlayListLoaded) {
                  setState(() {
                    isPlayListLoading = false;
                  });
                }
              },
              child: _content(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    Widget tabBarSong = NewsSongs();
    if (isNewSongsLoading && isPlayListLoading) {
      tabBarSong = Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: AppColors.primary),
      );
    }

    return Column(
      children: [
        BasicAppbar(
          title: SvgPicture.asset(AppVectors.logo, height: 40),
          hideBack: true,
          action: IconButton(
            onPressed: () {
              context.pushNamed(AppRoutes.profile.name);
            },
            icon: Icon(
              Icons.person,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0, -10, 0),
          child: _homeArtistCard(),
        ),
        SizedBox(height: 30),
        _tabs(),
        SizedBox(height: 30),
        SizedBox(
          height: 240,
          child: TabBarView(
            controller: _tabController,
            children: [tabBarSong, Container(), Container(), Container()],
          ),
        ),
        SizedBox(height: 40),
        if (!isNewSongsLoading && !isPlayListLoading) PlayList(),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _homeArtistCard() {
    return Center(
      child: SizedBox(
        height: 167,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homeTopCard),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 55),
                child: Image.asset(AppImages.homeArtist),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelColor: context.isDarkMode ? Color(0xffDBDBDB) : Colors.black,
      unselectedLabelColor: context.isDarkMode
          ? Color(0xff616161)
          : Color(0xffBEBEBE),
      indicatorColor: AppColors.primary,
      dividerColor: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      tabs: [
        Text(
          'News',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Videos',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Artists',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Podcasts',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
