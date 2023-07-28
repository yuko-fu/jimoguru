json.extract! vote_photo, :id, :image, :content, :vote_id, :created_at, :updated_at
json.url vote_photo_url(vote_photo, format: :json)
