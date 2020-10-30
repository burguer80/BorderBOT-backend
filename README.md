# Border BOT 🤖
![BorderBOT](https://user-images.githubusercontent.com/47440/63899038-34df7e80-c9b0-11e9-9ff6-949a10d4fe8a.png)

Ruby On Rails application to pull the latest Port Wait Times from the official site [U.S. CBP](https://bwt.cbp.gov/).

# General Information
**Requirements**:
- Ruby 2.7.0
- Rails 6+
- PostgreSQL
- Redis

- This project is over-engineering ***for Learning/Experimentation purposes***. 
- Data is stored in a Redis DB.
- Data persistence was removed temporary due the code refactoring it will be implemented once the front-end is finished. (to save 💵)


**Future Plans**:
- Add wait time predictions
- Remove outdated logic that is not longer used
- Deploy the application to a better deployment infrastructure with no restrictions.

## Getting Started

1. clone the project:

        $ gh repo clone burguer80/BorderBOT-backend

2. clone the project:

        $ db create
        $ db migrate
        
3. Change directory to `BorderBOT-backend` and start the web server:

        $ cd BorderBOT-backend
        $ bin/rails server


# Available End Points
---

***Health***

`http://localhost:3000/health`

[Demo endpoint](https://burguerbot-staging.herokuapp.com/health)

Response:
```
{
  "api": "OK"
}
```

---
***Ports***
Return an array with all the Ports details

`http://localhost:3000/ports`

[Demo endpoint](https://burguerbot-staging.herokuapp.com/ports)

Response:
```
[
  {
    "id": "070801",
    "details": {
      "name": "Alexandria Bay",
      "hours": "24 hrs/day",
      "opens_at": 0,
      "closed_at": 24,
      "border_name": "Canadian Border",
      "crossing_name": "Thousand Islands Bridge"
    },
    "time_zone": "EDT",
    "created_at": "2017-01-29T19:20:21.884-08:00",
    "updated_at": "2020-10-18T00:12:38.205-07:00"
  },
 ...
]
```
---
***Latest Wait Time***

`http://localhost:3000/latest_wait_times/{port_number}`

[Demo endpoint](https://burguerbot-staging.herokuapp.com/latest_wait_times/230302)

Response:
```
{
  "id": "230302",
  "lanes": {
    "private": {
      "fast": {
        "update_time": "At 6:00 pm CDT",
        "operational_status": "no delay",
        "delay_minutes": "1",
        "lanes_open": "1"
      },
      "standard": {
        ...
      },
      "ready": {
        ...
      }
    },
    "commercial": {
      ...
    },
    "pedestrian": {
      ...
    },
  },
  "details": {
    "name": "Eagle Pass",
    "hours": "24 hrs/day",
    "opens_at": 0,
    "closed_at": 24,
    "border_name": "Mexican Border",
    "crossing_name": "Bridge II"
  },
  "hours": "24 hrs/day",
  "last_update_time": "10/29/2020 6:00 pm CDT", # AM/PM format
  "port_time": "10/29/2020 18:09:26  CDT"  # 24-hour format
}
```

## Contributing

Any help will always be appreciated. 😁