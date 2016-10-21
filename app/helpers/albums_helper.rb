module AlbumsHelper
  def user(id)
    User.find(id)
  end
end
