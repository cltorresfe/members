module SearchableMember
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { number_of_shards: 1 } do
        mappings dynamic: 'false' do
          indexes :first_name, analyzer: 'english'
          indexes :last_name, analyzer: 'english'
          indexes :family do
            indexes :name, analyzer: 'english'
          end
        end
      end

    def self.search(term)
      __elasticsearch__.search(
        {
          query: {
            multi_match: {
              query: term,
              fields: ['first_name^10', 'last_name', 'family.name^5']
            }
          }
        }
      )
    end  
  end
  def as_indexed_json(options = {})
    self.as_json({
      only: [:first_name, :last_name],
      include: {
        family: { only: :name }
      }
    })
  end
end
