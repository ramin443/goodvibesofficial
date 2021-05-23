import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodvibesoffl/bloc/composer/composer_bloc.dart';
import 'package:goodvibesoffl/bloc/dynamic_homepage/dynamichomepagewidget_bloc.dart';
import 'package:goodvibesoffl/bloc/homepage_count.dart/homepage_count_bloc.dart';
import 'package:goodvibesoffl/bloc/rituals/rituals_bloc.dart';
import 'bloc/composer/composer_bloc.dart';
import 'bloc/downloadpage/downloadpage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/bloc/downloadpage/downloadpage_bloc.dart';
import 'package:goodvibesoffl/bloc/favourite/favourite_bloc.dart';
import 'package:goodvibesoffl/bloc/genre_page/genrepage_bloc.dart';
//import 'package:goodvibesoffl/bloc/history_page/history_bloc.dart';
//import 'package:goodvibesoffl/bloc/homepage_recommend_dialog/homepage_recommend_bloc.dart';
//import 'package:goodvibesoffl/bloc/latest_tracks/latest_tracks_bloc.dart';
//import 'package:goodvibesoffl/bloc/lets_meditate/lets_meditate_bloc.dart';
//import 'package:goodvibesoffl/bloc/meditate_page/meditate_bloc.dart';
import 'package:goodvibesoffl/bloc/musicPlayer/musicplayer_bloc.dart';
//import 'package:goodvibesoffl/bloc/notifications_bloc/notificationsbloc_bloc.dart';
import 'package:goodvibesoffl/bloc/playlist_bloc/playlist_bloc.dart';
//import 'package:goodvibesoffl/bloc/recently_played/recently_played_bloc.dart';
import 'package:goodvibesoffl/bloc/settings/settings_bloc.dart';
//import 'package:goodvibesoffl/bloc/sleep/sleep_bloc.dart';
//import 'package:goodvibesoffl/bloc/trending/trending_bloc.dart';
//import 'package:goodvibesoffl/bloc/reminder_page/reminderpage_bloc.dart';
//import 'package:goodvibesoffl/bloc/user_recomend/user_recommend_bloc.dart';
import 'package:goodvibesoffl/bloc/view_all/view_all_bloc.dart';
import 'package:goodvibesoffl/bloc/what_brings_you_here/what_brins_you_here_bloc.dart';
import 'bloc/dynamic_homepage/dynamichomepagewidget_bloc.dart';
import 'bloc/favourite/favourite_icon/favouriteicon_bloc.dart';
//import 'bloc/invite/invite_bloc.dart';
import 'bloc/profile_page_bloc/profilepage_bloc.dart';
import 'bloc/rituals/rituals_bloc.dart';
//import 'bloc/subscription_details/subscription_details_bloc.dart';
import "bloc/genre_songs_bloc/genresongs_bloc.dart";

class MultiBlocProviders extends StatelessWidget {
  final Widget child;
  const MultiBlocProviders({@required this.child});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DownloadpageBloc>(
            create: (BuildContext context) => DownloadpageBloc()),
        BlocProvider<GenrePageBloc>(
          create: (BuildContext context) => GenrePageBloc(),
        ),
   //     BlocProvider<TrendingBloc>(
     //     create: (BuildContext context) => TrendingBloc(),
       // ),
  //      BlocProvider<LatestTracksBloc>(
    //      create: (BuildContext context) => LatestTracksBloc(),
      //  ),
   //     BlocProvider<ReminderpageBloc>(
     //     create: (BuildContext context) => ReminderpageBloc(),
       // ),
        BlocProvider<FavouriteBloc>(
          create: (BuildContext context) => FavouriteBloc(),
          lazy: true,
        ),
        BlocProvider<FavouriteiconBloc>(
          create: (BuildContext context) => FavouriteiconBloc(),
          lazy: true,
        ),
        BlocProvider<SettingsBloc>(
          create: (BuildContext context) => SettingsBloc(),
          lazy: true,
        ),
   //     BlocProvider<HomepageRecommendBloc>(
     //     create: (BuildContext context) => HomepageRecommendBloc(),
       //   lazy: true,
       // ),
//        BlocProvider<MeditateBloc>(
  //        create: (BuildContext context) => MeditateBloc(),
    //    ),
        BlocProvider<PlaylistBloc>(
          create: (BuildContext context) => PlaylistBloc(),
        ),
        BlocProvider<MusicplayerBloc>(
          create: (BuildContext context) => MusicplayerBloc(),
        ),
        BlocProvider<WhatBrinsYouHereBloc>(
          create: (BuildContext context) => WhatBrinsYouHereBloc(),
        ),
  //      BlocProvider<RecentlyPlayedBloc>(
    //      create: (BuildContext context) => RecentlyPlayedBloc(),
      //  ),
   //     BlocProvider<HistoryBloc>(
     //     create: (BuildContext context) => HistoryBloc(),
       // ),
        //BlocProvider<UserRecomendBloc>(
      //    create: (BuildContext context) => UserRecomendBloc(),
    //    ),
   //     BlocProvider<NotificationsBloc>(
     //     create: (BuildContext context) => NotificationsBloc(),
       // ),
   //     BlocProvider<SleepBloc>(
     //     create: (BuildContext context) => SleepBloc(),
       // ),
        BlocProvider<ViewAllBloc>(
          create: (BuildContext context) => ViewAllBloc(),
        ),
  //      BlocProvider<LetsMediatateBloc>(
    //      create: (BuildContext context) => LetsMediatateBloc(),
      //  ),
        BlocProvider<ProfilepageBloc>(
          create: (BuildContext context) => ProfilepageBloc(),
        ),
 //       BlocProvider<SubscriptionDetailsBloc>(
   //       create: (BuildContext context) => SubscriptionDetailsBloc(),
     //   ),
        BlocProvider<ProfilepageBloc>(
          create: (BuildContext context) => ProfilepageBloc()
            ..add(
              ProfileFetchData(),
            ),
        ),
        BlocProvider<HomepageCountBloc>(
          create: (BuildContext context) => HomepageCountBloc(),
        ),
        BlocProvider<GenresongsBloc>(
          create: (BuildContext context) => GenresongsBloc(),
        ),
        BlocProvider<DynamichomepagewidgetBloc>(
          create: (BuildContext context) => DynamichomepagewidgetBloc(),
        ),
//        BlocProvider<InappPurchaseBloc>(
  //        create: (BuildContext context) => InappPurchaseBloc(),
    //    ),
        BlocProvider<ComposerBloc>(
          create: (BuildContext context) => ComposerBloc(),
        ),
//        BlocProvider<InviteBloc>(
  //        create: (BuildContext context) => InviteBloc(),
    //    ),
        BlocProvider<RitualsBloc>(
          create: (BuildContext context) => RitualsBloc(),
        ),
      ],
      child: child,
    );
  }
}
