module SearchableMinistry
  extend ActiveSupport::Concern

  included do
    def self.search(term)
      term ? where('lower(name) LIKE ?', "%#{term.downcase}%") : none
    end
  end
end
