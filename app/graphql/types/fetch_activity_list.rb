class Types::FetchActivityList < Types::BaseObject
  field :items, [Types::FetchActivityListItem], null: true
  field :count, Int, "The count of activities that match requested activity list type.", null: true
end