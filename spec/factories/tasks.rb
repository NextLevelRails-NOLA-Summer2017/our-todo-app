FactoryGirl.define do
  factory :task do
    association :user
    name "MyString"
    due_date { DateTime.now }
    priority 1
  end

  factory :homework, class: Task do
    association :user
    name 'Do homework'
    due_date { DateTime.now }
    priority 1
  end

  factory :email, class: Task do
    association :user
    name 'Reply to the important email'
    due_date { DateTime.now + 2.days }
    priority 2
  end

  factory :invalid_task, class: Task do
    association :user
    name nil
    due_date { DateTime.now }
    priority nil
  end
end
