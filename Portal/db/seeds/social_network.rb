SocialNetwork.find_or_create_by(network_name: "Github") do |sn|
  sn.network_short_name = "GH"
end

SocialNetwork.find_or_create_by(network_name: "facebook") do |sn|
  sn.network_short_name = "FB"
end

SocialNetwork.find_or_create_by(network_name: "twitter") do |sn|
  sn.network_short_name = "TW"
end

SocialNetwork.find_or_create_by(network_name: "Instagram") do |sn|
  sn.network_short_name = "IG"
end

SocialNetwork.find_or_create_by(network_name: "Pinterest") do |sn|
  sn.network_short_name = "PT"
end

SocialNetwork.find_or_create_by(network_name: "google_oauth2") do |sn|
  sn.network_short_name = "G+"
end

SocialNetwork.find_or_create_by(network_name: "linkedin") do |sn|
  sn.network_short_name = "ln"
end

# SocialNetwork.find_or_create_by(network_name: "google_oauth2", network_short_name: "G+")
# SocialNetwork.find_or_create_by(network_name: "linkedin", network_short_name: "ln")

puts "Social Networks added"