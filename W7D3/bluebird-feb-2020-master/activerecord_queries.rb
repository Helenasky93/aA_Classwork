# to run ActiveRecord query, enter your query below, then load this file in the rails console

def run_query
  # Chirp
  #   .joins(:author)
  #   .where(users: {age: 11})
  #   .joins(:likers)
  #   .where(users: {age: 11})

  # Chirp
  #   .joins(:likers, :author)
  #   .where(users: {age: 11})
  #   .where(authors_chirps: {age: 11})

  # chirps without likes :(
  # Chirp
  #   .left_outer_joins(:likes)
  #   .where(likes: {id: nil})

  # Chirp
  #   .joins(:author)
  #   .where(users: {username: "Andy"})
  #   .select(:body)

    # Chirp
    # .joins(:author)
    # .where(users: {username: "Andy"})
    # .pluck(:body)

    # Chirp
    # .joins(:likes)
    # .group(:id)
    # .having("COUNT(*) >= 3")
    # .pluck(:id, :body, "COUNT(*) as num_likes")

    # Chirp
    #   .joins(:likers, :author)
    #   .where(authors_chirps: {username: 'Nimbus'})
    #   .order("COUNT(*) DESC")
    #   .group("users.id")
    #   .pluck("users.username, COUNT(*) as num_likes")

    Chirp
      .joins(:comments)
      .group(:id)
      .order("COUNT(*) DESC")
      .limit(1)
    
end