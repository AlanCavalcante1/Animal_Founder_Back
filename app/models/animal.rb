class Animal < ApplicationRecord
  belongs_to :user
  has_many :answers 

  mount_uploader :photo, ImageUploader

  validates :name, :city, presence: true, length: {maximum:64}
  validates :age, numericality: true

  enum state:{
    'not_state':0, 'AC':1,'AL':2,'AP':3,'AM':4,'BA':5,'CE':6,'ES':7,'GO':8,'MA':9,'MT':10,'MS':11,'MG':12,'PA':13,'PB':14,'PR':15,'PE':16,'PI':17,'RJ':18,'RN':19,'RS':20,'RO':21,'RR':22,'SC':23,'SP':24,'SE':25,'TO':26,'DF':27,
  }

  enum status:{
    'lost':0,
    'release':1,
    'found':2,
}
  
end
