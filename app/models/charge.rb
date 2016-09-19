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

class Charge < ApplicationRecord
  belongs_to :ministry
  belongs_to :responsibility
  has_many :charge_members
  has_many :members, through: :charge_members

  def non_administrative
    joins(:responsibility).where(responsibilities: { administrative: false })
  end

  def by_responsibilities
    joins(:responsibility).group(:responsibility_id)
                          .select('charges.responsibility_id, count (*)')
  end
end
