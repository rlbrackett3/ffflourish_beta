Factory.define :fbot, :class => User do |fbot|
  fbot.first_name             "fbot"
  fbot.last_name              "messenger"
  fbot.email                  "fbot@ffflourish.com"
  fbot.email_confirmation     { |u| u.email }
  fbot.password               "foobar"
  fbot.password_confirmation  { |u| u.password }
end

