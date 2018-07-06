# WeTransfer X Spotify

Using this will help you sharing your playlist with friends through WeTransfer.

When you login, you will have a overview of all the playlist on your account. Next to the overview you'll have the posibility to share all your playlist via a WeTransfer link.

### Instalation

Request a WeTransfer API key: [developers.wetransfer.com](developers.wetransfer.com)
Register a Spotify APP: [developer.spotify.com](developer.spotify.com) and make sure you whitelist the callback url from the authentication e.q.: `http://localhost:3000/auth/spotify/callback`

Put those into the .env file file (I provided a .example.env)

Then run `rails db:create` for creating the database

And run `rails server` to test.
