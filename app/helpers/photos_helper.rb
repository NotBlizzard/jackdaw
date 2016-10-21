module PhotosHelper
  def user(id)
    User.find(id)
  end
end
