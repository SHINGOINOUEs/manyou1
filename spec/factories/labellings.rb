FactoryBot.define do
  factory :labelling do
    association :test_label
    association :label_task
  end
end

