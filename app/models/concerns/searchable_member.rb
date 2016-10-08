module SearchableMember
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name "#{Rails.env}-members"

    settings  number_of_shards: 1,
              analysis: {
                filter: {
                  'autocomplete_filter' => {
                    type: 'edge_ngram',
                    min_gram: 1,
                    max_gram: 20
                  }
                },
                analyzer: {
                  autocomplete: {
                    tokenizer: :standard,
                    filter: %w(lowercase autocomplete_filter)
                  }
                }
              } do
      mappings dynamic: 'false' do
        indexes :first_name, analyzer: :autocomplete
        indexes :last_name, analyzer: :autocomplete
        indexes :family do
          indexes :name, analyzer: :autocomplete
        end
      end
    end

    def self.refresh_idx
      __elasticsearch__.create_index! force: true
      __elasticsearch__.import
    end

    def self.search(term)
      __elasticsearch__.search(
        query: {
          multi_match: {
            query: term,
            analyzer: :standard,
            fields: ['first_name^4', 'last_name^4', 'family.name^1']
          }
        }
      )
    end
  end

  def as_indexed_json(_options = {})
    as_json(
      only: [:first_name, :last_name],
      include: [family: { only: :name }]
    )
  end
end
