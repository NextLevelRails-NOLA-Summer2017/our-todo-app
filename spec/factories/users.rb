FactoryGirl.define do
  factory :user do
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    email { FFaker::Internet.email }

    factory :user_with_tasks do

      after(:build) do |user|
        [:homework, :email].each do |task|
          user.tasks << FactoryGirl.build(task, user: user)
        end # making the tasks
      end # after build

    end # user with tasks
  end # user
end #factory
