class ContentSerializer < ActiveModel::Serializer
  attributes :id, :category, :title, :when, :detail
  has_many :taggings
  has_many :tags, through: :taggings

  class TaggingSerializer < ActiveModel::Serializer
    attributes #taggingの内容が出力されることを抑制。本当はtagging自体出力されなくしたいが。
  end

  class TagSerializer < ActiveModel::Serializer
    attributes :name
  end
end
