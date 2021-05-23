const download_table = 'download';
const history_table = 'history';
const favourite_table = 'favourite';
const reminder_table = 'reminder';
const settings_table = "settings";
const user_table = "user";

const saved_group_audios_table = "saved_group_audios_table";

const composer_audio_files = "composer_audio_files";
const composer_category_table = "composer_category_table";
const composer_downloaded_files = "composer_downloaded_files";

// playlists

const playlist_table = "playlist_table";
const rituals_table = "rituals_table";

final Map<int, String> databaseMigrations = {
  1: _createFavoriteTable,
  2: _createDownoadTable,
  3: _createHistoryTable,
  4: _createReminderTable,
  5: _createSettingsTable,
  6: _createUserTable,
  7: _createComposerAudioFilesTable,
  8: _createSavedCompoerGroupsTable,
  9: _createComposerCategoryTable,
  10: _createCompoerDownloadedTable,
  11: _createPlaylistTable,
  12: _addPlaylistIdInTrackTable,
  13: _createRitualsTable,
  14: _addShowTimerColInDownload,
  15: _addShowTimerColInHistory,
  16: _addPlanColInUserTable,
  17: _addGenderColInSettings,
  18: _addGenderColInUser
};

var _createFavoriteTable = '''CREATE TABLE IF NOT EXISTS "$favourite_table" (
                                                      "id"	INTEGER UNIQUE,
                                                      "title"	TEXT,
                                                      "filename"	TEXT,
                                                      "duration"	TEXT,
                                                      "cid"	INTEGER,
                                                      "description"	TEXT,
                                                      "url"	TEXT,
                                                      "cname"	TEXT,
                                                      "composer"	TEXT,
                                                      "image"	TEXT
                                                )''';

var _createDownoadTable = '''CREATE TABLE IF NOT EXISTS "$download_table" (
                                              "id"	INTEGER,
                                                "title"	TEXT,
                                                "filename"	TEXT,
                                                "duration"	TEXT,
                                                "cid"	INTEGER,
                                                "description"	TEXT,
                                                "url"	TEXT,
                                                "cname"	TEXT,
                                                "composer"	TEXT,
                                                "image"	TEXT,
                                                "download_id" INTEGER,
                                                "datetime" TEXT,
                                                "track_download_url" TEXT,
                                                "downloaded" INTEGER
                                 
                              )''';

var _createHistoryTable = '''CREATE TABLE IF NOT EXISTS "$history_table" (
                                                      "id"	INTEGER,
                                                      "title"	TEXT,
                                                      "filename"	TEXT,
                                                      "duration"	TEXT,
                                                      "cid"	INTEGER,
                                                      "description"	TEXT,
                                                      "url"	TEXT,
                                                      "cname"	TEXT,
                                                      "composer"	TEXT,
                                                      "image"	TEXT,
                                                      "datetime" TEXT,
                                                      "play_count" INTEGER,
                                                      "paid" INTEGER
                                                  
                                                )''';

var _createReminderTable = '''CREATE TABLE IF NOT EXISTS "$reminder_table" (
                                              "id"	INTEGER,
                                                "time"	TEXT,
                                                "day"	TEXT,
                                                "status" INTEGER,
                                                "reminderID" INTEGER
                              )''';

var _createSettingsTable = ''' CREATE TABLE IF NOT EXISTS "$settings_table" (
        "id" INTEGER,
        "email" TEXT,
        "full_name" TEXT,
        "country" TEXT,
        "city" TEXT,
        "state" TEXT,
        "address" TEXT,
        "key" TEXT,
        "device" TEXT,
        "paid" TEXT,
        "free_trail" TEXT,
        "login_type" TEXT,
        "admin" TEXT,
        "user_image" TEXT,
        "user_image_standard" TEXT,
        "active" TEXT,
        "created_at" TEXT,
        "plan" TEXT,
        "status" TEXT,
        "disabled" TEXT,
        "daily_updates_push" TEXT,
        "offers_push" TEXT,
        "others_push" TEXT

      ) ''';

var _createUserTable = '''CREATE TABLE IF NOT EXISTS "$user_table" (
                                                "uid"	TEXT,
                                                "email"	TEXT,
                                                "name" TEXT,
                                                "image" TEXT,
                                                "type" TEXT,
                                                "authToken" TEXT,
                                                "isLoggedIn" INTEGER,
                                                "paid" INTEGER,
                                                "passwordSet" INTEGER,
                                                "meditationDay" INTEGER,
                                                "minToday" INTEGER,
                                                "badgeLevel" INTEGER,
                                                "tags" TEXT,
                                                "freeTrial" INTEGER ,
                                                "country" TEXT,
                                                "city" TEXT,
                                                "state" TEXT,
                                                "address" TEXT,
                                                "dob" TEXT
                                               
                                               
                                               
                              )''';

var _createComposerAudioFilesTable =
'''CREATE TABLE IF NOT EXISTS "$composer_audio_files" (
        "id" INTEGER,
        "fileName" TEXT,
        "dateAdded" TEXT,
        "audioPathType" TEXT,
        "audioTitle" TEXT,
        "defaultVolume" NUMERIC,
        "paid" INTEGER,
        "image" TEXT,
       "category" TEXT,
       "categoryId" INTEGER,
       "url" TEXT,
       "downloadUrl" TEXT
      ) ''';

var _createSavedCompoerGroupsTable =
'''CREATE TABLE IF NOT EXISTS "$saved_group_audios_table" (
        "groupId"  INTEGER PRIMARY KEY AUTOINCREMENT,
        "group_id_api" INTEGER,
        "group_json" TEXT,
        "group_name"  TEXT
    ) ''';

var _createComposerCategoryTable =
'''CREATE TABLE IF NOT EXISTS "$composer_category_table" (
      "id" INTEGER,
      "name" TEXT
      )
      ''';

var _createCompoerDownloadedTable =
''' CREATE TABLE IF NOT EXISTS  "$composer_downloaded_files" (
      "id" INTEGER ,
      'audioTitle' TEXT,
      "fileName" TEXT,
      "path" TEXT,
      "taskID" TEXT
        )  ''';

var _addGenderColInUser =
'''ALTER TABLE $user_table ADD COLUMN  "gender" TEXT ''';

var _addGenderColInSettings =
'''ALTER TABLE $settings_table ADD COLUMN  "gender" TEXT ''';

var _createPlaylistTable = '''CREATE TABLE IF NOT EXISTS "$playlist_table" (
  "id" INTEGER,
  "title" VARCHAR,
  "description" TEXT,
  "length" INTEGER,
  "image" VARCHAR,
  "slug" VARCHAR,
  "playables_count" INTEGER,
  "total_progress" DECIMAL,
  "completion_status" VARCHAR,
  "total_duration" DECIMAL,
  "played_duration" DECIMAL
) ''';

var _addPlaylistIdInTrackTable =
'''ALTER TABLE   "$download_table" ADD COLUMN "playlist_id" INTEGER ''';

var _createRitualsTable = '''CREATE TABLE IF NOT EXISTS "$rituals_table"(
  "id" INTEGER,
  "title"	TEXT,
  "filename"	TEXT,
  "duration"	DECIMAL,
  "played_duration" DECIMAL,
  "completion_status" VARCHAR,
  "cid" INTEGER ,
  "description"	TEXT  ,
  "url"	TEXT  ,
  "download_url" TEXT,
  "cname"	TEXT,
  "composer"	TEXT,
  "image"	TEXT,
  "download_id" INTEGER,
  "datetime" TEXT,
  "track_download_url" TEXT,
  "downloaded" INTEGER,
  "track_paid_type" VARCHAR,
  "playlist_id" INTEGER
  ) ''';

var _addShowTimerColInDownload =
'''ALTER TABLE "$download_table" ADD COLUMN "show_timer" ''';

var _addShowTimerColInHistory =
'''ALTER TABLE "$history_table" ADD COLUMN "show_timer" ''';

var _addPlanColInUserTable = '''ALTER TABLE $user_table ADD COLUMN 'plan' ''';
