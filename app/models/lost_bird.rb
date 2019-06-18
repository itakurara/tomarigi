class LostBird < ApplicationRecord
  include Elasticsearch::Model

  # TODO:
  # mapping dynamic: 'strict' do
  #   indexes :description, analyzer: 'kuromoji', type: 'text'
  #   indexes :kind, analyzer: 'kuromoji', type: 'text'
  #   indexes :lost_at, type: 'date'
  #   indexes :found_at, type: 'date'
  #   indexes :status, type: 'keyword'
  #   indexes :place, type: 'text'
  # end

  belongs_to :bird
  belongs_to :address

  before_save :normalize_blank

  def normalize_blank
    attributes.each do |column, _value|
      self[column] = self[column].presence
    end
  end

  # TODO:
  # def as_indexed_json(options={})
  #   self.as_json(only: 'description')
  # end
end
