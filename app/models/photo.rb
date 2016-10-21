require 'securerandom'
class Photo < ActiveRecord::Base
  validates :title, presence: true
  validates :photo, presence: true
  before_save :make_slug
  has_many :comments
  belongs_to :album

  has_attached_file :photo,
      :storage => :s3,
        :s3_host_name => "s3.amazonaws.com",
      :s3_credentials => Proc.new { |a| a.instance.s3_credentials },
      :styles => {:medium => "500x500>", :thumb => "100x100>"},
      :url    => ":s3_domain_url",
      :path   => "/:class/:attachment/:id_partition/:style/:filename"


  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  belongs_to :user

  def s3_credentials
    {:bucket => ENV["AWS_BUCKET"], :access_key_id => ENV["AWS_KEY_ID"], :secret_access_key => ENV["AWS_SECRET_KEY"]}
  end
  def make_slug
    extension = File.extname(photo_file_name).downcase
    self.slug ||= SecureRandom.urlsafe_base64(10)
  end
end
