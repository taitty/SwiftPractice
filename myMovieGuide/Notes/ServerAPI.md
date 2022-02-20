# Movie DB
- https://www.themoviedb.org/

# Movie API
### Guide
- https://developers.themoviedb.org/3/getting-started
### API 키 (v3 auth)
- 620adaf60ebc1f8a0a4e88ca439f04ce
### API 읽기 액세스 토큰 (v4 auth)
- eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MjBhZGFmNjBlYmMxZjhhMGE0ZTg4Y2E0MzlmMDRjZSIsInN1YiI6IjYxZWZiNDg0ZTQ4ODYwMDAxZTAyOTUyYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QUFExSUhZ4Pg0Jb72olxS6y4OhY109cVDy8HkezSRd8
### API 요청 (sample)
- request
  - https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1

<details markdown="1">
<summary> response(sample) </summary>

```javascript
{
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/1Rr5SrvHxMXHu5RjKpaMba8VTzi.jpg",
      "genre_ids": [
        28,
        12,
        878
      ],
      "id": 634649,
      "original_language": "en",
      "original_title": "Spider-Man: No Way Home",
      "overview": "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
      "popularity": 9425.322,
      "poster_path": "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
      "release_date": "2021-12-15",
      "title": "Spider-Man: No Way Home",
      "video": false,
      "vote_average": 8.5,
      "vote_count": 5898
    },
    {
      "adult": false,
      "backdrop_path": "/k2twTjSddgLc1oFFHVibfxp2kQV.jpg",
      "genre_ids": [
        28,
        12,
        14,
        878
      ],
      "id": 524434,
      "original_language": "en",
      "original_title": "Eternals",
      "overview": "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.",
      "popularity": 7590.729,
      "poster_path": "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg",
      "release_date": "2021-11-03",
      "title": "Eternals",
      "video": false,
      "vote_average": 7.3,
      "vote_count": 3513
    },
    {
      "adult": false,
      "backdrop_path": "/qBLEWvJNVsehJkEJqIigPsWyBse.jpg",
      "genre_ids": [
        16,
        10751,
        14,
        35,
        12
      ],
      "id": 585083,
      "original_language": "en",
      "original_title": "Hotel Transylvania: Transformania",
      "overview": "When Van Helsing's mysterious invention, the \"Monsterfication Ray,\" goes haywire, Drac and his monster pals are all transformed into humans, and Johnny becomes a monster. In their new mismatched bodies, Drac and Johnny must team up and race across the globe to find a cure before it's too late, and before they drive each other crazy.",
      "popularity": 6951.326,
      "poster_path": "/teCy1egGQa0y8ULJvlrDHQKnxBL.jpg",
      "release_date": "2022-01-13",
      "title": "Hotel Transylvania: Transformania",
      "video": false,
      "vote_average": 7.7,
      "vote_count": 1111
    },
    {
      "adult": false,
      "backdrop_path": "/3G1Q5xF40HkUBJXxt2DQgQzKTp5.jpg",
      "genre_ids": [
        16,
        35,
        10751,
        14
      ],
      "id": 568124,
      "original_language": "en",
      "original_title": "Encanto",
      "overview": "The tale of an extraordinary family, the Madrigals, who live hidden in the mountains of Colombia, in a magical house, in a vibrant town, in a wondrous, charmed place called an Encanto. The magic of the Encanto has blessed every child in the family with a unique gift from super strength to the power to heal—every child except one, Mirabel. But when she discovers that the magic surrounding the Encanto is in danger, Mirabel decides that she, the only ordinary Madrigal, might just be her exceptional family's last hope.",
      "popularity": 4382.986,
      "poster_path": "/4j0PNHkMr5ax3IA8tjtxcmPU3QT.jpg",
      "release_date": "2021-11-24",
      "title": "Encanto",
      "video": false,
      "vote_average": 7.8,
      "vote_count": 3428
    },
    {
      "adult": false,
      "backdrop_path": "/tutaKitJJIaqZPyMz7rxrhb4Yxm.jpg",
      "genre_ids": [
        35,
        16,
        10751,
        10402
      ],
      "id": 438695,
      "original_language": "en",
      "original_title": "Sing 2",
      "overview": "Buster and his new cast now have their sights set on debuting a new show at the Crystal Tower Theater in glamorous Redshore City. But with no connections, he and his singers must sneak into the Crystal Entertainment offices, run by the ruthless wolf mogul Jimmy Crystal, where the gang pitches the ridiculous idea of casting the lion rock legend Clay Calloway in their show. Buster must embark on a quest to find the now-isolated Clay and persuade him to return to the stage.",
      "popularity": 4053.564,
      "poster_path": "/aWeKITRFbbwY8txG5uCj4rMCfSP.jpg",
      "release_date": "2021-12-01",
      "title": "Sing 2",
      "video": false,
      "vote_average": 8.3,
      "vote_count": 1335
    },
    {
      "adult": false,
      "backdrop_path": "/o76ZDm8PS9791XiuieNB93UZcRV.jpg",
      "genre_ids": [
        27,
        28,
        878
      ],
      "id": 460458,
      "original_language": "en",
      "original_title": "Resident Evil: Welcome to Raccoon City",
      "overview": "Once the booming home of pharmaceutical giant Umbrella Corporation, Raccoon City is now a dying Midwestern town. The company’s exodus left the city a wasteland…with great evil brewing below the surface. When that evil is unleashed, the townspeople are forever…changed…and a small group of survivors must work together to uncover the truth behind Umbrella and make it through the night.",
      "popularity": 4076.337,
      "poster_path": "/7uRbWOXxpWDMtnsd2PF3clu65jc.jpg",
      "release_date": "2021-11-24",
      "title": "Resident Evil: Welcome to Raccoon City",
      "video": false,
      "vote_average": 6.1,
      "vote_count": 1014
    },
    {
      "adult": false,
      "backdrop_path": "/EnDlndEvw6Ptpp8HIwmRcSSNKQ.jpg",
      "genre_ids": [
        35,
        14,
        12
      ],
      "id": 425909,
      "original_language": "en",
      "original_title": "Ghostbusters: Afterlife",
      "overview": "When a single mom and her two kids arrive in a small town, they begin to discover their connection to the original Ghostbusters and the secret legacy their grandfather left behind.",
      "popularity": 3385.542,
      "poster_path": "/sg4xJaufDiQl7caFEskBtQXfD4x.jpg",
      "release_date": "2021-11-11",
      "title": "Ghostbusters: Afterlife",
      "video": false,
      "vote_average": 7.7,
      "vote_count": 1532
    },
    {
      "adult": false,
      "backdrop_path": "/t4To8feUSysyBs4tlBAbXIrKlCv.jpg",
      "genre_ids": [
        28,
        53
      ],
      "id": 860623,
      "original_language": "en",
      "original_title": "Last Man Down",
      "overview": "After civilization succumbs to a deadly pandemic and his wife is murdered, a special forces soldier abandons his duty and becomes a hermit in the Nordic wilderness. Years later, a wounded woman appears on his doorstep. She's escaped from a lab and her pursuers believe her blood is the key to a worldwide cure. He's hesitant to get involved, but all doubts are cast aside when he discovers her pursuer is none other than Commander Stone, the man that murdered his wife some years ago.",
      "popularity": 3164.772,
      "poster_path": "/tBP2yKtoWUjx8cD82qhFAoBbsSo.jpg",
      "release_date": "2021-10-19",
      "title": "Last Man Down",
      "video": false,
      "vote_average": 6.7,
      "vote_count": 148
    },
    {
      "adult": false,
      "backdrop_path": "/eNI7PtK6DEYgZmHWP9gQNuff8pv.jpg",
      "genre_ids": [
        878,
        28,
        12
      ],
      "id": 624860,
      "original_language": "en",
      "original_title": "The Matrix Resurrections",
      "overview": "Plagued by strange memories, Neo's life takes an unexpected turn when he finds himself back inside the Matrix.",
      "popularity": 2718.099,
      "poster_path": "/8c4a8kE7PizaGQQnditMmI1xbRp.jpg",
      "release_date": "2021-12-16",
      "title": "The Matrix Resurrections",
      "video": false,
      "vote_average": 6.9,
      "vote_count": 2490
    },
    {
      "adult": false,
      "backdrop_path": "/vIgyYkXkg6NC2whRbYjBD7eb3Er.jpg",
      "genre_ids": [
        878,
        28,
        12
      ],
      "id": 580489,
      "original_language": "en",
      "original_title": "Venom: Let There Be Carnage",
      "overview": "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
      "popularity": 2286.786,
      "poster_path": "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg",
      "release_date": "2021-09-30",
      "title": "Venom: Let There Be Carnage",
      "video": false,
      "vote_average": 7.1,
      "vote_count": 6002
    },
    {
      "adult": false,
      "backdrop_path": "/dK12GIdhGP6NPGFssK2Fh265jyr.jpg",
      "genre_ids": [
        28,
        35,
        80,
        53
      ],
      "id": 512195,
      "original_language": "en",
      "original_title": "Red Notice",
      "overview": "An Interpol-issued Red Notice is a global alert to hunt and capture the world's most wanted. But when a daring heist brings together the FBI's top profiler and two rival criminals, there's no telling what will happen.",
      "popularity": 1780.725,
      "poster_path": "/lAXONuqg41NwUMuzMiFvicDET9Y.jpg",
      "release_date": "2021-11-04",
      "title": "Red Notice",
      "video": false,
      "vote_average": 6.8,
      "vote_count": 2793
    },
    {
      "adult": false,
      "backdrop_path": "/AmLpWYm9R3Ur2FLPgj5CH3wR8wp.jpg",
      "genre_ids": [
        878,
        53
      ],
      "id": 739413,
      "original_language": "en",
      "original_title": "Mother/Android",
      "overview": "Georgia and her boyfriend Sam go on a treacherous journey to escape their country, which is caught in an unexpected war with artificial intelligence. Days away from the arrival of their first child, the couple must face No Man’s Land—a stronghold of the android uprising—in hopes of reaching safety before giving birth.",
      "popularity": 1622.148,
      "poster_path": "/rO3nV9d1wzHEWsC7xgwxotjZQpM.jpg",
      "release_date": "2021-12-17",
      "title": "Mother/Android",
      "video": false,
      "vote_average": 5.8,
      "vote_count": 322
    },
    {
      "adult": false,
      "backdrop_path": "/2Jp2RIwJ3Dt7vamkTt7llVJ7uY.jpg",
      "genre_ids": [
        53,
        9648,
        18
      ],
      "id": 916740,
      "original_language": "en",
      "original_title": "Brazen",
      "overview": "Mystery writer Grace Miller has killer instincts when it comes to motive - and she'll need every bit of expertise to help solve her sister's murder.",
      "popularity": 2048.129,
      "poster_path": "/7e4n1GfC9iky9VQzH3cDQz9wYpO.jpg",
      "release_date": "2022-01-13",
      "title": "Brazen",
      "video": false,
      "vote_average": 4.8,
      "vote_count": 150
    },
    {
      "adult": false,
      "backdrop_path": "/mo57hzhW3BcZL1f7MNteWKHsmlN.jpg",
      "genre_ids": [
        28,
        53
      ],
      "id": 763788,
      "original_language": "en",
      "original_title": "Dangerous",
      "overview": "A reformed sociopath heads to a remote island after the death of his brother. Soon after his arrival, the island falls under siege from a deadly gang of mercenaries, and when he discovers their role in his brother’s demise, he sets out on a relentless quest for vengeance.",
      "popularity": 1389.765,
      "poster_path": "/vTtkQGC7qKlSRQJZYtAWAmYdH0A.jpg",
      "release_date": "2021-11-05",
      "title": "Dangerous",
      "video": false,
      "vote_average": 6.6,
      "vote_count": 127
    },
    {
      "adult": false,
      "backdrop_path": "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg",
      "genre_ids": [
        28,
        12,
        14
      ],
      "id": 566525,
      "original_language": "en",
      "original_title": "Shang-Chi and the Legend of the Ten Rings",
      "overview": "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.",
      "popularity": 1523.712,
      "poster_path": "/1BIoJGKbXjdFDAqUEiA2VHqkK1Z.jpg",
      "release_date": "2021-09-01",
      "title": "Shang-Chi and the Legend of the Ten Rings",
      "video": false,
      "vote_average": 7.8,
      "vote_count": 5330
    },
    {
      "adult": false,
      "backdrop_path": "/7esxXkFyl0dVD7ViR0Q6fK5VeXB.jpg",
      "genre_ids": [
        28,
        53,
        80
      ],
      "id": 787310,
      "original_language": "en",
      "original_title": "Survive the Game",
      "overview": "When cop David is injured in a drug bust gone wrong, his partner Cal chases the two criminals who shot him. They all land at a remote farm owned by troubled vet Eric, and as Cal and Eric plot their defense, more of the gang arrives - along with a wounded David. Outnumbered, the three heroes must use stealth, smarts, and good shooting to take down the drug-dealing mob.",
      "popularity": 1167.044,
      "poster_path": "/xF1uc2pEf34X2G41wvZaF5H0V7C.jpg",
      "release_date": "2021-10-08",
      "title": "Survive the Game",
      "video": false,
      "vote_average": 5.9,
      "vote_count": 84
    },
    {
      "adult": false,
      "backdrop_path": "/xPpXYnCWfjkt3zzE0dpCNME1pXF.jpg",
      "genre_ids": [
        16,
        28,
        12,
        14
      ],
      "id": 635302,
      "original_language": "ja",
      "original_title": "劇場版「鬼滅の刃」無限列車編",
      "overview": "Tanjirō Kamado, joined with Inosuke Hashibira, a boy raised by boars who wears a boar's head, and Zenitsu Agatsuma, a scared boy who reveals his true power when he sleeps, boards the Infinity Train on a new mission with the Fire Hashira, Kyōjurō Rengoku, to defeat a demon who has been tormenting the people and killing the demon slayers who oppose it!",
      "popularity": 1230.022,
      "poster_path": "/h8Rb9gBr48ODIwYUttZNYeMWeUU.jpg",
      "release_date": "2020-10-16",
      "title": "Demon Slayer -Kimetsu no Yaiba- The Movie: Mugen Train",
      "video": false,
      "vote_average": 8.4,
      "vote_count": 2067
    },
    {
      "adult": false,
      "backdrop_path": "/1Wlwnhn5sXUIwlxpJgWszT622PS.jpg",
      "genre_ids": [
        16,
        35,
        10751
      ],
      "id": 585245,
      "original_language": "en",
      "original_title": "Clifford the Big Red Dog",
      "overview": "As Emily struggles to fit in at home and at school, she discovers a small red puppy who is destined to become her best friend. When Clifford magically undergoes one heck of a growth spurt, becomes a gigantic dog and attracts the attention of a genetics company, Emily and her Uncle Casey have to fight the forces of greed as they go on the run across New York City. Along the way, Clifford affects the lives of everyone around him and teaches Emily and her uncle the true meaning of acceptance and unconditional love.",
      "popularity": 1134.269,
      "poster_path": "/oifhfVhUcuDjE61V5bS5dfShQrm.jpg",
      "release_date": "2021-11-10",
      "title": "Clifford the Big Red Dog",
      "video": false,
      "vote_average": 7.4,
      "vote_count": 926
    },
    {
      "adult": false,
      "backdrop_path": "/9fzNf2QcsHVvdx5g5QUOgAWpADw.jpg",
      "genre_ids": [
        18,
        27,
        9648
      ],
      "id": 516329,
      "original_language": "en",
      "original_title": "Antlers",
      "overview": "A small-town Oregon teacher and her brother, the local sheriff, discover a young student is harbouring a dangerous secret that could have frightening consequences.",
      "popularity": 977.516,
      "poster_path": "/cMch3tiexw3FdOEeZxMWVel61Xg.jpg",
      "release_date": "2021-10-28",
      "title": "Antlers",
      "video": false,
      "vote_average": 6.4,
      "vote_count": 407
    },
    {
      "adult": false,
      "backdrop_path": "/1BqX34aJS5J8PefVnQSfQIEPfkl.jpg",
      "genre_ids": [
        80,
        28,
        53
      ],
      "id": 826749,
      "original_language": "en",
      "original_title": "Fortress",
      "overview": "The story revolves around a top-secret resort for retired U.S. intelligence officers. A group of criminals led by Balzary breach the compound, hellbent on revenge on Robert, forcing the retired officer and his son to save the day.",
      "popularity": 940.17,
      "poster_path": "/vQxtoPJVfpHgL7DCg9hQFZKDWJa.jpg",
      "release_date": "2021-12-17",
      "title": "Fortress",
      "video": false,
      "vote_average": 6.4,
      "vote_count": 126
    }
  ],
  "total_pages": 32064,
  "total_results": 641279
}
```

</details>


# API Configuration
### response 내용을 간소화하기 위해서, Base URL 및 사이즈 정보를 별도로 제공
- request
  - https://api.themoviedb.org/3/configuration?api_key=<<api_key>>

<details markdown="1">
<summary> response(sample) </summary>

```javascript
{
  "images": {
    "base_url": "http://image.tmdb.org/t/p/",
    "secure_base_url": "https://image.tmdb.org/t/p/",
    "backdrop_sizes": [
      "w300",
      "w780",
      "w1280",
      "original"
    ],
    "logo_sizes": [
      "w45",
      "w92",
      "w154",
      "w185",
      "w300",
      "w500",
      "original"
    ],
    "poster_sizes": [
      "w92",
      "w154",
      "w185",
      "w342",
      "w500",
      "w780",
      "original"
    ],
    "profile_sizes": [
      "w45",
      "w185",
      "h632",
      "original"
    ],
    "still_sizes": [
      "w92",
      "w185",
      "w300",
      "original"
    ]
  },
  "change_keys": [
    "adult",
    "air_date",
    "also_known_as",
    "alternative_titles",
    "biography",
    "birthday",
    "budget",
    "cast",
    "certifications",
    "character_names",
    "created_by",
    "crew",
    "deathday",
    "episode",
    "episode_number",
    "episode_run_time",
    "freebase_id",
    "freebase_mid",
    "general",
    "genres",
    "guest_stars",
    "homepage",
    "images",
    "imdb_id",
    "languages",
    "name",
    "network",
    "origin_country",
    "original_name",
    "original_title",
    "overview",
    "parts",
    "place_of_birth",
    "plot_keywords",
    "production_code",
    "production_companies",
    "production_countries",
    "releases",
    "revenue",
    "runtime",
    "season",
    "season_number",
    "season_regular",
    "spoken_languages",
    "status",
    "tagline",
    "title",
    "translations",
    "tvdb_id",
    "tvrage_id",
    "type",
    "video",
    "videos"
  ]
}
```

</details>

# How to get Image
### API Configuration 의 Base URL 과 Size 정보에, Image ID 를 추가해서 요청
- Base URL
  - https://image.tmdb.org/t/p/
- Size
  - w342
- Image ID (Movie Data 내에 있음 ex. /popular)
  - 1g0dhYtq4irTY1GPXvft6k4YLjm.jpg
### request
- https://image.tmdb.org/t/p/w342/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg
