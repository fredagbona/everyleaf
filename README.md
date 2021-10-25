# README


## Ruby version
* Ruby 2.6.5

## Task Model
| Column      | Description |
| ----------- | ----------- |
| name      | string       |
| description   | Text        |
| status   | Text        |
| priority   | string        |
| user_id(FK)  | bigint        |
| expiration_date   | string        |

## User Model
| Column      | Description |
| ----------- | ----------- |
| name      | string       |
| email   | string        |
| pasword   | string        |
| admin   | boolean        |

## Label Model
| Column      | Description |
| ----------- | ----------- |
| name      | string       |
| task_id   | bigint        |

## Deploy on Heroku Steps

```bash
$ heroku git:clone -a everyleaf-fred
$ cd everyleaf-fred
$ git add .
$ git commit -am "make it better"
$ git push heroku master
``` 