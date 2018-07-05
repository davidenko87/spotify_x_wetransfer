class TransferExporter
  require 'we_transfer_client'

  def initialize(items)
    @wt_client = WeTransferClient.new(api_key: ENV['WT_API_KEY'])
    @items = items
  end

  def create_transfer
    transfer = @wt_client.create_transfer(name: 'Spotify Playlist Collection',
                                          description: 'A collection of my spotify playlists') do |upload|
      @items.each do |item|
        upload.add_file_at(path: item[:image])
        upload.add_web_url(url: item[:link], title: item[:title])
      end
    end
    transfer.shortened_url
  end
end