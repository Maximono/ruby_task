# Ruby task

 By Maxym Tesliuk.

### Prerequisites


```sh
ruby 2.5.1

bundler
```

### Installation

```sh
bundle install
```

### Task
original condition

```sh
Query.filter{ status == 0 }.filter{ requests > 5 }.from(5).sort(:id, name: :desc).size(10).to_json
```
should result as following
```sh
{
  "query": {
      "status": 0,
"requests": {
        "gt": 5
      }
  }, 
  "sort": [
    {
      "id": "asc"
    },
    {
      "name": "desc"
    }
  ],
  "size": 10,
  "from": 5
}
```

condition based on my assumptions

```sh
Query.new.filter({status: {eq: 0}}).filter({requests: {gt: 5}}).from(5).sort(:id, name: :desc).size(10).to_json
``` 
### How to run
In irb

```sh
require_relative 'query.rb'
```


### Rspec
```sh
rspec
```
