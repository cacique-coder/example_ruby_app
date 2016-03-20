class User < ActiveRecord::Base
  include Statusable
  devise :database_authenticatable, authentication_keys: {email: false, login: true}

  validates_presence_of(:name, :login, :saint_id)

  def self.types
    {
      'Superadmin': 'User::Superadmin',
      'Vendedor': 'User::Salesman',
      'Supervisor': 'User::Supervisor',
      'Administracion': 'User::Administration'
    }
  end

  def self.custom_authentication(params)
    user = where(login: params[:login].downcase).first
    return nil if user.nil? or user.inactive?
    if user.valid_password?(params[:password])
      user.generate_token!
      user
    else
      nil
    end
  end

  def guest?
    false
  end

  def generate_token!
    self.token = new_token_generated
    self.save
  end

  def new_token_generated
    Digest::SHA1.hexdigest( "#{Time.new.to_s}#{login}" )[0,32]

  end
end
