prefecture= [
  '1', '13', '14', '22', '40'
]

address = [
  '北海道札幌市', '東京都世田谷区', '神奈川県横浜市', '静岡県浜松市', '福岡県福岡市'
]

vegetables = [
  "キャベツ", "とうもろこし", "じゃがいも", "さつまいも", "玉ねぎ"
]

5.times do |i|
  user = User.create!(
    role: 1,
    name: "一般ユーザー#{i + 1}",
    email: "general#{i + 1}@example.com",
    password: "password"
  )

  General.create!(
    user_id: user.id,
    prefecture_id: "#{prefecture[i]}",
    address: "#{address[i]}",
    name: "一般ユーザー#{i + 1}",
    favorite_crop: "#{vegetables[i + 1]}"
  )
end

5.times do |i|
  user = User.create!(
    role: 0,
    name: "農家ユーザー#{i + 1}",
    email: "farmer#{i + 1}@example.com",
    password: "password"
  )

  farmer = Farmer.create!(
    user_id: user.id,
    name: "農家ユーザー#{i + 1}",
    prefecture_id: "#{prefecture[i]}",
    address: "#{address[i]}",
    product: "#{vegetables[i]}",
    website: "https://farmer#{i + 1}.example.com",
    profile: "農家ユーザー#{i + 1}のプロフィールです。",
    station: "#{address[i]}駅",
    plots_attributes: [
      { name: "農地#{i + 1}" },
    ]
  )
end

5.times do |i|
  farmer = Farmer.find_by(name: "農家ユーザー#{i + 1}")

  experience = Experience.new(
    farmer_id: farmer.id,
    title: "体験情報#{i + 1}",
    content: "これは体験情報#{i + 1}の内容です。"
  )

  experience.plot_ids = [farmer.plots.first.id]
  experience.save!
end

Experience.all.each do |experience|
  3.times do |i|
    Schedule.create!(
      experience_id: experience.id,
      title: "スケジュール #{i + 1}",
      start_time: DateTime.now + (i + 1).days,
      end_time: DateTime.now + (i + 1).days + 2.hours
    )
  end
end

Farmer.all.each do |farmer|
  3.times do |i|
    Post.create!(
      farmer_id: farmer.id,
      title: "投稿タイトル #{i + 1}",
      content: "投稿内容 #{i + 1} "
    )
  end
end

User.all.each do |user|
  2.times do
    followed_user = User.where.not(id: user.id).sample
    unless user.following?(followed_user)
      user.follow!(followed_user)
    end
  end
end

users = User.all

users.each do |user1|
  users.sample(3).each do |user2|
    next if user1 == user2

    conversation = Conversation.find_or_create_by(sender_id: user1.id, recipient_id: user2.id)

    5.times do |i|
      message = Message.create(
        body: "メッセージ#{i + 1}",
        conversation_id: conversation.id,
        user_id: [user1.id, user2.id].sample,
        read: [true, false].sample
      )
    end
  end
end

(1..5).each do |i|
  farmer = Farmer.find(i)
  image_path = Rails.root.join("db/images/farmer_image#{i}.jpg")
  farmer.image.attach(io: File.open(image_path), filename: "farmer_image#{i}.jpg", content_type: "image/jpeg") if farmer
end

(1..5).each do |i|
  experience = Experience.find_by(farmer_id: i)
  image_path = Rails.root.join("db/images/experience_image#{i}.jpg")
  experience.images.attach(io: File.open(image_path), filename: "experience_image#{i}.jpg", content_type: "image/jpeg") if experience
end

(1..5).each do |i|
  post = Post.find_by(farmer_id: i)
  image_path = Rails.root.join("db/images/post_image#{i}.jpg")
  post.images.attach(io: File.open(image_path), filename: "post_image#{i}.jpg", content_type: "image/jpeg") if post
end