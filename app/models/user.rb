# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#  name                   :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable, :recoverable,
  # :lockable, :timeoutable and :omniauthable, :validatable
  devise :database_authenticatable,
         :rememberable, :trackable


  # validates :password,
  #           :presence => {:on => :update},
  #           :length => {:minimum => 6, :allow_nil => true},
  #           :confirmation => true
  validates_presence_of :password, :on => :create
  validates_length_of :password, :minimum => 6,
    :allow_nil => true, :on => :create
  validates :password, :confirmation => Proc.new { |object| object.password.present? }


  has_many :cutoffs
  has_many :categories


  def to_s
    self.name.present? ? self.name : self.email
  end


  def non_admin?
    !self.admin?
  end

end
