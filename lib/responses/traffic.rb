module GitHub
  module Resources
    module Responses

      TRAFFIC_REFERRERS ||= [
        {"referrer" => "Google", "count" => 4, "uniques" => 3},
        {"referrer" => "stackoverflow.com", "count" => 2, "uniques" => 2},
        {"referrer" => "eggsonbread.com", "count" => 1, "uniques" => 1},
        {"referrer" => "yandex.ru", "count" => 1, "uniques" => 1}]

      TRAFFIC_CONTENTS ||= [
        {
          "path"    => "/github/hubot",
          "title"   => "github/hubot: A customizable life embetterment robot.",
          "count"   => 3542,
          "uniques" => 2225
        },
        {
          "path"    => "/github/hubot/blob/master/docs/scripting.md",
          "title"   => "hubot/scripting.md at master · github/hubot · GitHub",
          "count"   => 1707,
          "uniques" => 804
        },
        {
          "path"    => "/github/hubot/tree/master/docs",
          "title"   => "hubot/docs at master · github/hubot · GitHub",
          "count"   => 685,
          "uniques" => 435
        },
        {
          "path"    => "/github/hubot/tree/master/src",
          "title"   => "hubot/src at master · github/hubot · GitHub",
          "count"   => 577,
          "uniques" => 347
        },
        {
          "path"    => "/github/hubot/blob/master/docs/index.md",
          "title"   => "hubot/index.md at master · github/hubot · GitHub",
          "count"   => 379,
          "uniques" => 259
        },
        {
          "path"    => "/github/hubot/blob/master/docs/adapters.md",
          "title"   => "hubot/adapters.md at master · github/hubot · GitHub",
          "count"   => 354,
          "uniques" => 201
        },
        {
          "path"    => "/github/hubot/tree/master/examples",
          "title"   => "hubot/examples at master · github/hubot · GitHub",
          "count"   => 340,
          "uniques" => 260
        },
        {
          "path"    => "/github/hubot/blob/master/docs/deploying/heroku.md",
          "title"   => "hubot/heroku.md at master · github/hubot · GitHub",
          "count"   => 324,
          "uniques" => 217
        },
        {
          "path"    => "/github/hubot/blob/master/src/robot.coffee",
          "title"   => "hubot/robot.coffee at master · github/hubot · GitHub",
          "count"   => 293,
          "uniques" => 191
        },
        {
          "path"    => "/github/hubot/blob/master/LICENSE.md",
          "title"   => "hubot/LICENSE.md at master · github/hubot · GitHub",
          "count"   => 281,
          "uniques" => 222
        }]

      TRAFFIC_VIEWS ||= {
          "count" => 7,
          "uniques" => 6,
          "views" => [
                  {"timestamp" => 1464710400000, "count" => 1, "uniques" => 1},
                  {"timestamp" => 1464732000000, "count" => 2, "uniques" => 1},
                  {"timestamp" => 1465214400000, "count" => 1, "uniques" => 1},
                  {"timestamp" => 1465218000000, "count" => 1, "uniques" => 1},
                  {"timestamp" => 1465300800000, "count" => 2, "uniques" => 2}]}

      TRAFFIC_CLONES ||= {
         "count" => 7,
         "uniques" => 6,
         "clones" => [
                  {"timestamp" => 1464710400000, "count" => 1, "uniques" => 1},
                  {"timestamp" => 1464732000000, "count" => 2, "uniques" => 1},
                  {"timestamp" => 1465214400000, "count" => 1, "uniques" => 1},
                  {"timestamp" => 1465218000000, "count" => 1, "uniques" => 1},
                  {"timestamp" => 1465300800000, "count" => 2, "uniques" => 2}]}
   end
  end
end
