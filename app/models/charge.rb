class Charge < ActiveRecord::Base
  belongs_to :ministry
  belongs_to :responsibility
end
