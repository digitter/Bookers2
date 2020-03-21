class User < ApplicationRecord
  validates :introduction, length: { muximum: 50 }
end
