# fetch-api

- Intro.
- Authentication / Sign in.
- User detail.
- Sign up.
- Update user.

## Overview

API for Fetch. Written in Rails with GraphQL.

A Staging app that you can experiment with can be found at the following URL: https://rylabs-fetch-api.herokuapp.com/graphql

We're using the [Electron GraphiQL][] app to issue queries/mutations and view documentation.

## Authentication

All queries/mutations are guarded by authentication (except for the `signIn` and `signUp` mutations). To make requests to the API, you'll need to issue a `signIn` mutation:

```graphql
mutation SignIn($email: String!, $password: String!) {
  signIn(email: $email, password: $password) {
    authenticationToken
  }
}
```

with the following variables (note that we're using a seed account for a member):

```javascript
{
  "email": "member@example.com",
  "password": "member"
}
```

That will return an authentication token that you can then add to the `Authorization` header (you can easily set auth headers with the GraphiQL client): `Authorization: Bearer <token>` where `<token>` is the authentication token that you received back from the `signIn` mutation.

## API Documentation

To see documenation for the API, sign in with a user account and click the "Docs" button on the right side of the GraphiQL interface. There, you'll be able to see all of the available queries, mutations, and types as well as descriptions for all of them.

## Project Structure

This is a Rails 5 app created using [ry-rails][]. Please check README of the template repository to see the features available out of the box. To have a look to the new features introduced by Rails 5.2 (credentials for example), check this [article][].

## How to use this project

- We advise you to use [overmind][] to launch your processes in development. You just need to run `overmind s -f Procfile.dev`. Of course, another process manager, like [foreman][], would work too.
- We advise you to deploy to [Heroku][]. Do not forget to add the [Redis] add-on.

[article]: https://evilmartians.com/chronicles/rails-5-2-active-storage-and-beyond
[modern-rails-template]: https://github.com/damienlethiec/modern-rails-template
[here]: http://nvie.com/posts/a-successful-git-branching-model/
[overmind]: https://github.com/DarthSim/overmind
[foreman]: https://github.com/ddollar/foreman
[heroku]: https://www.heroku.com/
[redis]: https://devcenter.heroku.com/articles/heroku-redis
[electron graphiql]: https://electronjs.org/apps/graphiql
