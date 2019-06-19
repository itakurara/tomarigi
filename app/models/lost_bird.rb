class LostBird < ApplicationRecord
  include Elasticsearch::Model

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
