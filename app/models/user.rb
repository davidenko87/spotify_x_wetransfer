class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:spotify]


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.uid = auth.uid
      user.provider = auth.provider
      user.email = auth.info.email
      user.access_token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
    end
  end
end
