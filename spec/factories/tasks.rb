FactoryBot.define do
  factory :task do
    title { 'タスクのテスト1' }
    content { 'テストサンプル1' } 
    deadline {'2023-02-25'}
    status {'closed'}
    priority {'low'}
    user
  end

  factory :second_task, class: Task do
    title { 'タスクのテスト2' }
    content { 'テストサンプル2' }
    deadline {'2023-02-23'}
    status {'in_progress'}
    priority {'common'}
    user
  end

  factory :third_task, class: Task do
    title { 'タスクのテスト3' }
    content { 'テストサンプル3' }
    deadline {'2023-02-12'}
    status {'outstanding'}  
    priority {'high'}
    user
  end
end
