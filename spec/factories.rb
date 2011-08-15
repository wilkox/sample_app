#a factory for test users
Factory.define :user do |user|
  user.name "Santa Claws"
  user.email "paste@example.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
