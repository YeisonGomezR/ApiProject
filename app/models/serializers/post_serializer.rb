class PostSerializer < ActiveModel::Serializer
    attributes :id, :title, :body
    belogs_to :user
end

class UserSerializer < ActiveModel::Serializer
    attributes :id, :name
end