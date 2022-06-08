# Poll_App

Run npm install from a project directory.

To boot the dev server run npm run dev.

This app uses the pg-promise for connecting to a Postgres database server. Run the poll.sql code to Postgres, to create the database needed for the app.

While using this app, the client can publish, vote, and see the results of polls. Two polls are already created and stored in the database. The newcly created polls will also be stored in the database.

In order to access the homepage, the client can type the URL below in the browser:

```bash
localhost:8080
```

To view the results of a specific poll, the URL below should be accessed:

```bash
localhost:8080/results/:id (ID of the poll)
```

To vote on a poll, the URL below will direct the client to the vote page:

```bash
localhost:8080/vote/:id (ID of the poll)
```

