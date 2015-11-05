class User < ActiveRecord::Base
	has_many :rides

	has_secure_password

	validates :email, :password, presence: true
	validates :email, uniqueness: true
	validates_confirmation_of :password
	# has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100X100>"}, default_url: ":style/missing.png"
	# validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

	def self.confirm(params)
	user = User.find_by_email(params[:email])	
	user.try(:authenticate, params[:password])
	end
end
