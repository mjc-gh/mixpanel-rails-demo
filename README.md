# Mixpanel Demo App

This is a demo for [Elegantly integrate Mixpanel with your Rails app
using built-in instrumentation on
dev.to](https://dev.to/mjc/elegantly-integrate-mixpanel-with-your-rails-app-using-built-in-instrumentation-32mn).

## Setup

You should be able to run this able with the following minimal setup:

```
rails db:migrate
rails credentials:edit --environment development
```

When your editor opens, add the token to a new Mixpanel project to the
YAML as follow:

```yml
mixpanel_token: [token]
```

Now you can run the app as follows:

```
rails s -p 3000
```

And open [this page](http://localhost:3000).
