class LostBird < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  MATCH_PHRASE_FIELDS = %w(lost_address found_address kind)

  index_name "lost_birds_#{Rails.env}"

  mapping dynamic: 'strict' do
    indexes :description, analyzer: 'kuromoji', type: 'text'
    indexes :kind, analyzer: 'kuromoji', type: 'text'
    indexes :lost_at, type: 'date'
    indexes :found_at, type: 'date'
    indexes :ring_number, analyzer: 'kuromoji', type: 'text'
    indexes :name, analyzer: 'kuromoji', type: 'text'
    indexes :lost_address, analyzer: 'kuromoji', type: 'text'
    indexes :lost_address_for_aggs, type: 'keyword'
    indexes :found_address, analyzer: 'kuromoji', type: 'text'
    indexes :found_address_for_aggs, type: 'keyword'
    indexes :status, type: 'keyword'
    indexes :resolved, type: 'boolean'
    indexes :created_at, type: 'date'
  end

  belongs_to :bird
  belongs_to :user
  has_many_attached :photos
  has_many :comments
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
    term_queries = []

    if status = params[:status]
      term_queries << { term: { status: status } }
    end

    unless params[:include_resolved] == 'true'
      term_queries << { term: { resolved: false } }
    end

    (term_queries << range_queries(params)).compact
  end

  def self.match_queries(params)
    params = params.except(:status, :include_resolved, :date, :date_range, :meet_all_conditions)

    match_queries = []
    params.each do |k, v|
      if v.present?
        if MATCH_PHRASE_FIELDS.include? k
          match_queries << { match_phrase: { k => v } }
        else
          match_queries << { match: { k => v } }
        end
      end
    end

    match_queries
  end

  def self.range_queries(params)
    return unless date_param = params[:date].presence
    return unless range_param = params[:date_range].presence

    date = date_param.to_date
    range = case range_param
            when 'week'
              1.week
            when 'month'
              1.month
            when 'half_a_year'
              6.months
            when 'year'
              1.year
            end

    case params[:status]
    when 'kept'
      { range: { found_at: { gte: date, lte: date + range } } }
    when 'lost'
      { range: { lost_at: { gte: date, lte: date + range } } }
    end
  end

  def as_indexed_json(options={})
    {
      description: description,
      kind: bird.ja_name,
      lost_at: lost_at,
      found_at: found_at,
      ring_number: ring_number,
      name: name,
      lost_address: lost_address,
      found_address: found_address,
      lost_address_for_aggs: lost_address,
      found_address_for_aggs: found_address,
      status: status,
      resolved: resolved,
      created_at: created_at
    }
  end
end
