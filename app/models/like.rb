class Like < Socialization::ActiveRecordStores::Like
  belongs_to :question
  belongs_to :user
end
