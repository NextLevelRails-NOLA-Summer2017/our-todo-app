FactoryGirl.define do
  factory :user do
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    email { FFaker::Internet.email }

    after(:build) do |user|
      [:homework, :email].each do |task|
        user.tasks << FactoryGirl.build(task, user: user)
      end
    end
  end
end
