import 'dart:io';

const cancel_token = 'dio_cancel_token';
const auth_token_key = 'auth_token';

const app_title = 'Good Vibes';

const demo_music_file =
    'https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_2MG.mp3';
const placeholder_url = 'https://i.ibb.co/QMwv7wn/placeholder.jpg';

const demo_2 =
    "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3";

const compose_flute_image =
    "https://api-stage.goodvibesofficial.com:4443/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBbElOIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--ff6f70903296e7354c81bbd315425dfe86739fbb/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9MY21WemFYcGxTU0lNTXpBd2VETXdNQVk2QmtWVSIsImV4cCI6bnVsbCwicHVyIjoidmFyaWF0aW9uIn19--b338ca2a321d51e2ca7e125ca225727e160f596f/flute.png";

/// subscription prices
const monthly_price = 'USD 4.99';
const per_month_yearly = '\$ 2.99';
const total_yearly = 'USD 35.88';
const free_trial_message = 'Free Trial for 7 days';

const monthly = 'Monthhly';
const per_month = 'Per Month';

const start_free_trial = 'Start Free Trial';
const yearly_title = 'Yearly';

//// app package ids

const app_apple_package_namw = "com.goodvibes";

const apple_sign_in_enpoint =
    "api.goodvibesofficial.com/auth/sign_in_with_apple";

/// product kids

const android_monthly = "com.goodvibes.monthly_android";
const android_yearly = "com.goodvibes.yearly_android";

const ios_monthly = "monthly.goodvibesofficial";
const ios_yearly = "com.goodvibes.yearlyautoios";

/// subscription page
const most_popular = 'Most Popular';
const try_for7_days = 'Try 7 days for free';
const sub_text1 = 'Unlock 1,500+ sound healing frequencies';
const sub_text2 = 'Daily new binaural frequencies';
const sub_text3 = 'Download and listen music offline';
const sub_text4 = 'Sleep Stories and Guided Meditation';
const sub_text5 = 'Daily Rituals to Health, Weatlth & Abundance';
const sub_text6 = "Enjoy Ad free experience";

/// privacy policy texts

const recurring_billig_info = 'Recurring billing. Cancel anytime.';
const restore_purchase_btn = 'Restore Purchase';

const payment_charged_to_account =
    'Your payment will be charged to your  Account after trial period.';
final _storeType = Platform.isIOS ? "Apple" : "Google Play Store";
final account_be_charged =
    'Your payment will be charged to your $_storeType Account at regular price after trial or introductory period ends. Your $_storeType account will be charged again when your subscription automatically renews at the end of your current subscription period unless auto-renew is turned off at least 24 hours prior to end of the current period.';

const manage_turn_off =
    'You can manage or turn off auto-renew in your  Account Settings any time.';
const privacy_policy = 'Privacy Policy ';
const terms_of_user = 'Terms of Use ';

//// restore purchase messages

const purchase_restored_message = 'Purchase Restored';
const no_purchase_found_message = 'No Purchases were found';

/// main page

const app_error_title = 'Uh... Error';
const app_error_message1 = "Something went wrong at our end.";
const app_error_message2 = "Don't worry it's not you - it's us.";
const app_error_message3 = "Sorry about that.";
const report_us = 'Report us';
const go_to_home = 'Go to home';
const close_the_app = 'Close the app';

///// login page texts
const sign_up = "Sign Up";
const log_in = 'Log In';
const login_facebook = 'Sign in with Facebook';
const login_gmail = 'Sign in with Gmail';
const login_email = 'Sign in with Email';
const login_apple = "Sign in with Apple";
const connect_google = "Connect with Google";
const connect_facebook = "Connect with Facebook";
const update_user = "Update";
const deactivte_account = "Deactivate Account";

const forgot_pass = 'Forgot password?  ';
const forgot_pass_title = "Forgot password";
const account_yet = "Don't have an account yet?  ";
const already_account = 'Already Have an Account?  ';
const login_success = 'Log in successful!';
const login_fail = 'Login failed';
const click_here = 'Click here';
const by_proceeding = 'By proceeding you agree to our\n';
const sign_in_title = "Sign in";
const change_password_title = "Change password";
//////////////////////////////////////////////////////////////////////
/// dialog box types

const delete_download = 'deleteDownload';
const remove_favorite = 'removeFavorite';
const cancel_download = 'cancelDownload';
const cannot_download = 'cannot be downloaded by unpaid user';
const only_one_download = 'only one download at a time';
const logout_user = "logout usser";
const unpaid_user_offline_access = "upadi user cannot acess offline";
const deactivate_account = "deactivate account";
const enablePlayServiceDialog = "enablePlayService";
const updatePlayServiceDialog = "updatePlayService";
const installPlayServiceDialog = "installPlayService";
const cannotSaveMoreMix = "free_user_can_save_only_2_mixes";
const premiumTrack = "premiumTrack";

/// dilog box messages
const are_you_sure = 'Are you sure you want to';
const delete_download_message = '$are_you_sure delete this track ?';
const remove_favorite_message = '$are_you_sure remove this track ?';
const cancel_download_message = '$are_you_sure cancel downloading?';
const unpaid_user_download_message =
    'Download Option is available to subscribed users only. Subscribe to download unlimited music.';

const pre_logout_message = "Are you sure you want to sign out?";
const only_one_download_message = 'Only one track can be downloaded at a time.';
const deactivate_account_message =
    "Are you sure you want to deactivate this account?";
// apple pay restore meessge
const apple_pay_message =
    'If you have previously upgraded to the pro version using an in-app purchase you are entitled to a free upgrade.\n\nApple does not charge twice for the same upgrade, as long as the iTunes. App Store account is the same as when it was originally purchased.\n\nWould you like to initiate this process now?';
const google_play_message =
    'If you have previously upgraded to the pro version using an in-app purchase you are entitled to a free upgrade.\n\nGoogle does not charge twice for the same upgrade.Google account is the same as when it was originally purchased.\n\nWould you like to initiate this process now?';

const google_play_store_url =
    'https://play.google.com/store/apps/details?id=com.goodvibes&';

const good_vibes_email = 'support@goodvibesofficial.com';

const support_email = 'support@goodvibesofficial.com';
const app_store_url =
    'https://apps.apple.com/us/app/good-vibes-official/id1454917657?ls=1';
const blog_url = "https://goodvibesofficial.com/blog";
////dialog boxes button names
const remove_t = "REMOVE";
const proceed_t = '';
const yes_t = '';
const no_t = '';
const stop_t = 'STOP';

/// music timer dilaog texts
const set_timer = 'Set Timer';
const timer_message = 'Music will Auto stop after playing';

//// serrings page dilaogs messages

const rate_message = 'Love the app?\nWe want your feedback.';
const remind_laater_message = 'REMIND ME LATER';
const five_star_rating = 'GIVE US 5 STAR';

const feedack_dialog_message =
    'Love the app?\nWe value your thoughts and concerns.';

const send_feedback_message = 'SEND FEEDBACK';
const social_media_user = 'Social Media User';
const logged_in_with_social =
    'Looks like you have logged in via Social Media\Reset password works for user logged in with Email only.';
//////////////////////////////////////////////////////////////////////////////////////////

/// login messages
const login_failed = "Could not login \n at the moment.";

/// splash and intro page and onboarding pages
const welcome_string = 'Welcome';

//// homepage texts
const trending_title = 'Trending';
const latest_tracks_title = 'Latest tracks';

const lets_meditate_title = "Let's Meditate";
const lets_meditate_subtitle = "Start Your Journey With Basics";
const recent_update_title = "Recent Updates";
const recent_update_subtitle = "Check out recent Meditation music";
const recent_played_title = "Recently Played";
const recent_played_subtitle = "Your recent played history";
const daily_recomend_title = "Daily Recommend";
const daily_recoment_subtitle = "Choose your daily choice";
const try_for_free = "Try for free";
const active_now = "Active Now";
///////genre page

const genre_page_title = 'Discover all our Relaxing Music';
const locading_message = 'Loading ...';

////////downloads page

const empty_downloads_message =
    'Download Tracks are Empty\n You can download the tracks for offline use.';
const download_page_title = 'Downloads';
const cancel_t = 'Cancel';
const no_data_available = 'No Data Available';

//////// reminder page messages

const reminder_bed_quote =
    'Going to bed at the same time each night is key to healthy sleep. What time do you want toget ready for bed';
const repeat_t = 'Repeat';
const all_reminder = 'All Reminders';
const select_time = "Select Time";
const set_rteminder_title = 'Set Reminder';

const reminder_notify_message =
    'You will be reminded by notification on the selected day(s) at';

const not_selected_message = 'Day & Time not Selected ?';
const select_day_message =
    'Please selet the day and time you would like to be reminded.';

const confirm_question = 'Confirm ?';
const close_t = 'Close';
const confirm_t = 'Confirm';
const reminder_title = "Meditation Reminder";
const motivational_text = '''we recommend setting a 
reminder to 
Practice meditation daily.''';

/// offline page messages and titles

const failure_message_woops = 'Whoops!';
const no_connection_message =
    'No internet connection found.\n Check your connection and try again';

const open_settings_btn = 'Open Settings';
const continue_offline_btn = 'Continue Offline';
const subscribe_t = 'Subscribe';
const retry_t = 'Retry';
const not_logged_message = 'Offline feature is available to paid users only.';

//////meditate page

const coming_soon = 'Coming Soon';
const medidate_page_message =
    'Fill your body with deep breaths and it will fill your with peace.';

/// settings page button titles and settings page
const profile_page_title = 'Profile';
const account_title = "Account";
const app_preference_title = "APP PREFERENCE";
const history_btn_title = 'History';
const favorite_btn_title = 'Favorite';
const remider_btn_title = 'Reminder';
const more_btn_title = 'More';
const rate_app_btn_title = 'Rate us';
const share_app_btn_title = 'Share App';
const share_url_android =
    'Good Vibes Official https://play.google.com/store/apps/details?id=com.goodvibes&hl=en_US';
const help_and_support_btn_title = 'Help';

const about_us_btn_title = 'About';
const feedback_btn_title = 'Feedback';
const sign_out_btn = 'SIGN OUT';
const change_password_t = 'Change Password';
const terms_and_conditions = 'Terms and Conditions';

const about_app_title = "ABOUT APP";
const account_settings = "Account Settings";
const manage_subscription = "Manage Subscription";
const notification_title = "Notifications";
const promo_code = "Promo Code";
const clear_data = "Clear data";
const meditation_reminder = "Reminder";
const invite_friends = 'Invite friends';

const blog_title = "Blog";

/// app url
/// s
const help_and_support_url = "https://goodvibesofficial.com/help/";
const about_us_url = "https://goodvibesofficial.com/about-us/";
const privacy_policy_url = "https://goodvibesofficial.com/privacy-policy/";
const terms_and_conditions_url =
    "https://goodvibesofficial.com/terms-and-conditions/";

//// error messages

const unauthorized_error = "User is unauthorized";

/// check your mail page
const check_your_mail_message = "Please check out your  Email";

const some_error_occured = "Some error occurred.";

//// profile page texts

const goals_title = "Goals";
const badge_title = "Badges";
const achivements_text = " Achievments record you've earned";
const view_achievements = "View all Achievements";
const edit_account = "edit account";
const tag_loading = "Loading ...";

// Achievemenet page Texts

const all_achievement_title = "All Achievements";
const achievement_badge = "Badges";
const achievement_you_earn = "Achievement Records you have earn";

// about us large texts
const about_us1 = '''
The user friendly Good Vibes app is here, 
as its name suggests, to relieve you of stress, fill you 
with joy, bring peace, prosperity, balance and 
harmony in your life. Music, as we all know is one 
of the best stress reliever and it’s music that heals
 you in bad times and magnifies you’re good
  times.''';
const about_us2 = '''Therefore, we are here at Good Vibes, spend 
ample time in majestic music production to make 
sure that our users have a relaxing and enjoyable time
 using your app to bring the desired changes
  in their life.''';

//No Data Available Page

const retry_text = "Retry";
const sorry_no_search_result =
    "Sorry, there are no result for this search.\nPlease try another phrase.";

List countriesList = [
  "KP",
  "HM",
  "MK",
  "SH",
  "GS",
  "VE",
  "NL",
  "FM",
  "YT",
  "LI",
  "LR",
  "LY",
  "LBR",
  "LS",
  "KI",
  "IM",
  "HM",
  "GW",
  "TF",
  "SJ",
  "SX",
  "SL",
  "ST",
  "VC",
  "PM",
  "AN",
  "AS",
  "AG",
  "IO",
  "BF",
  "BQ",
  "KY",
  "CC",
  "VA"
];

/// error messages

const error_msg_404 = "Something is wrong";
const error_msg_500 = "Server could not process the request.";

const error_msg_408 = "Connection Timeout occured!";
const error_msg_timeout = "Connection Timeout occured!";
const error_mdg_422 = "Could not process your request at the moment";
const error_error = "An error occured!";

//// invitation page's string constatns

const invitation_page_title =
    "Invite your friends and family, help them use\n our app and get 1 month premium.";

const cancel_invite_fail_message = "Could not cancel invitation.";
const already_accepted_invite = "Your friend has already accepted invitataion.";
const invite_send_success = "Invitation sent successfully!";
const error_inviting = "An error occured while inviting your friend.";
const your_friends = "Your Participating Friends";
const error_fetching_invites = "An error occured fetching invites";
