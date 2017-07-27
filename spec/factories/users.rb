FactoryGirl.define do
  factory :user do
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    password 'Password1'
    encrypted_password 'Password1'


    factory :user_with_tasks do
      after(:build) do |user|
        [:homework, :email].each do |task|
          user.tasks << FactoryGirl.build_stubbed(task, user: user)
        end # task iteration
      end # after build
    end # user_with_tasks

    factory :user_with_real_boy_tasks do
      after(:build) do |user|
        [:homework, :email].each do |task|
          user.tasks << FactoryGirl.build(task, user: user)
        end # task iteration
      end # after build
    end # user_with_tasks
  end
end
