class LostBird < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mapping dynamic: 'strict' do
    indexes :description, analyzer: 'kuromoji', type: 'text'
    indexes :kind, analyzer: 'kuromoji', type: 'text'
    indexes :lost_at, type: 'date'
    indexes :found_at, type: 'date'
    indexes :ring_number, analyzer: 'kuromoji', type: 'text'
    indexes :name, analyzer: 'kuromoji', type: 'text'
    indexes :address, analyzer: 'kuromoji', type: 'text'
    indexes :status, type: 'keyword'
    indexes :resolved, type: 'boolean'
  end

  belongs_to :bird
  enum status: [:lost, :kept]

  before_save :normalize_blank

  def normalize_blank
    attributes.each do |column, value|
      if value.is_a?(String)
        self[column] = self[column].presence
      end
    end
  end

  def self.lookup(params)
    __elasticsearch__.search(params_for_elasticsearch(params))
  end

  def self.params_for_elasticsearch(params)
    {
      query: {
        bool: build_bool_queries(params)
      }
    }
  end

  def self.build_bool_queries(params)
    if params[:meet_all_conditions] == 'true'
      {
        filter: filter_queries(params),
        must: match_queries(params)
      }
    else
      queries = {
        filter: filter_queries(params),
        should: match_queries(params)
      }
      if queries[:should].present?
        queries.merge!(minimum_should_match: 1)
      end
      queries
    end
  end

  def self.filter_queries(params)
    filter_queries = []

    if status = params[:status]
      filter_queries << { term: { status: status } }
    end

    unless params[:include_resolved] == 'true'
      filter_queries << { term: { resolved: false } }
    end

    filter_queries
  end

  def self.match_queries(params)
    params = params.except(:status, :include_resolved, :meet_all_conditions)
    match_queries = []
    params.each do |k, v|
      if v.present?
        if k == 'address'
          match_queries << { match_phrase: { k => v } }
        else
          match_queries << { match: { k => v } }
        end
      end
    end
    match_queries
  end

  def as_indexed_json(options={})
    {
      description: description,
      kind: bird.ja_name,
      lost_at: lost_at,
      found_at: found_at,
      ring_number: ring_number,
      name: name,
      address: address,
      status: status,
      resolved: resolved
    }
  end
end
