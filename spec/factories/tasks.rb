FactoryBot.define do
  factory :task do
    title { '写真共有アプリ' }
    content { 'テストサンプル1' } 
    deadline {'2023-02-25'}
    status {'closed'}
    priority {'low'}
  end

  factory :second_task, class: Task do
    title { '万葉課題ステップ2' }
    content { 'テストサンプル2' }
    deadline {'2023-02-23'}
    status {'in_progress'}
    priority {'common'}
  end

  factory :third_task, class: Task do
    title { '賃貸物件課題' }
    content { 'テストサンプル3' }
    deadline {'2023-02-12'}
    status {'outstanding'}  
    priority {'high'}
  end
end
