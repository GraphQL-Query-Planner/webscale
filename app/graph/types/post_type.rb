PostType = GraphQL::ObjectType.define do
  name 'Post'
  description 'A post made by a user'

  implements GraphQL::Relay::Node.interface

  global_id_field :id

  field :body, !types.String
  field :author, !UserType do
    resolve -> (post, _, _) do
      AssociationLoader.for(:author).load(post).then do
        post.author
      end
    end
  end
  field :receiver, !UserType
  field :likes, !types[LikeType]
  field :comments, !types[CommentType]
  field :comments_count, !types.Int do
    resolve -> (post, args, _) { post.comments.count }
  end
end
