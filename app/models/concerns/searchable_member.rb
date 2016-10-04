module SearchableMember
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings INDEX_OPTIONS do
        mappings dynamic: 'false' do
          indexes :first_name, analyzer: 'autocomplete'
          indexes :last_name, analyzer: 'autocomplete'
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

  INDEX_OPTIONS =
      { number_of_shards: 1, analysis: {
      filter: {
        "autocomplete_filter" => {
          type: "edge_ngram",
          min_gram: 1,
          max_gram: 20
        }
      },
      analyzer: {
        "autocomplete" => {
          type: "custom",
          tokenizer: "standard",
          filter: [
            "lowercase",
            "autocomplete_filter"
          ]
        }
      }
    }
  }
end
