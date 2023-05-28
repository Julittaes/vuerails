json.extract! rating, :id, :avg_rating, :location_rating, :facilities_rating, :created_at, :updated_at
json.url rating_url(rating, format: :json)
