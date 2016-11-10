class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :items

  validates_presence_of :name
  before_save :assign_role


  # 在函数内部的self应该是代表着实例
  # 而在方法上的self代表着这个方法是类方法.类似下面的这个函数
  # def self.name
  # end
  def assign_role
    self.role = Role.find_by name: "Regular" if self.role.nil?
  end

  def admin?
    self.role.name == "Admin"
  end

  def seller?
    self.role.name == "Seller"
  end

  def regular?
    self.role.name == "Regular"
  end


end
