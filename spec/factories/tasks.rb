FactoryBot.define do
  factory :task do
    title { 'タスクのテスト1' }
    content { 'テストサンプル1' } 
    deadline {'2023-02-12'}
  end

  factory :second_task, class: Task do
    title { 'タスクのテスト2' }
    content { 'テストサンプル2' }
    deadline {'2023-02-23'}
  end

  factory :third_task, class: Task do
    title { 'タスクのテスト3' }
    content { 'テストサンプル3' }
    deadline {'2023-02-25'}    
  end

end