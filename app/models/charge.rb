# == Schema Information
#
# Table name: charges
#
#  id                :integer          not null, primary key
#  ministry_id       :integer
#  responsibility_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Charge < ActiveRecord::Base
  belongs_to :ministry
  belongs_to :responsibility
end
