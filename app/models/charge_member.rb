class ChargeMember < ActiveRecord::Base
  belongs_to :charge
  belongs_to :member
end
