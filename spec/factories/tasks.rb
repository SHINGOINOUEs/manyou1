FactoryBot.define do
  factory :task do
    title { 'タスクのテスト1' }
    content { 'テストサンプル1' } 
  end

  factory :second_task, class: Task do
    title { 'タスクのテスト2' }
    content { 'テストサンプル2' }
  end

  factory :third_task, class: Task do
    title { 'タスクのテスト3' }
    content { 'テストサンプル3' }
  end

end