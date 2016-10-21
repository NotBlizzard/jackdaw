require 'digest/md5'
module UsersHelper
  def gravatar(user, s=80)
    url = "http://www.gravatar.com/avatar/"
    email = Digest::MD5.hexdigest(user.email.downcase)
    return url+email+"?s=#{s}"
  end
end
