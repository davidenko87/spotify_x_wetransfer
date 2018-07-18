class SpotifyConnection
  BASE_URI = 'https://api.spotify.com/v1'.freeze

  def initialize(user)
    @user = user
  end

  def user_information
    connection('https://api.spotify.com/v1/me')
  end

  def user_playlists
    list = []
    resp = connection("https://api.spotify.com/v1/users/#{@user.uid}/playlists?limit=50")
    list << resp['items']
    if resp['next'].present?
      resp = connection(resp['next'])
      list << resp['items']
      if resp['next'].present?
        resp = connection(resp['next'])
        list << resp['items']
      end
    end
    list.flatten!
  end

  def playlists_tracks(playlist_id)
    connection("https://api.spotify.com/v1/users/#{@user.uid}/playlists/#{playlist_id}/tracks")
  end

  def playlist_info(playlist_id)
    connection("https://api.spotify.com/v1/users/#{@user.uid}/playlists/#{playlist_id}")
  end

  def connection(url)
    response = Faraday.get(url) do |con|
      con.headers['Authorization'] = 'Bearer ' + @user.access_token
    end
    if response.status == 401
      refresh_token
      connection(url)
    else
      JSON.parse(response.body)
    end
  end


  def refresh_token
    client_cred = "#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}"
    resp = Faraday.post('https://accounts.spotify.com/api/token') do |con|
      con.headers['Authorization'] = "Basic #{Base64.strict_encode64(client_cred)}"
      con.body = {
        grant_type: 'refresh_token',
        refresh_token: @user.refresh_token
      }
    end
    response = JSON.parse(resp.body)
    @user.update_attributes(access_token: response['access_token'])
  end
end