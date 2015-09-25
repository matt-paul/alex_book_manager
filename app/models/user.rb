require 'bcrypt'

class User

include DataMapper::Resource

	attr_reader :password
	attr_accessor :password_confirmation
	validates_confirmation_of :password
	# validates_presence_of :email
	# This property d unnecesary in Datamapper because in user.rb email is 'required'. May be needed when working with other database mappers though


  property :id, Serial
  property :email, String, required: true

  property :password_digest, Text

  def password=(password)
  	@password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
