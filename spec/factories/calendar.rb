FactoryBot.define do
  factory :calendar, class: Calendar do
    name {'Test calendar'}
    description {'The description of the calendar'}
    url  {'Some url'}
  end
end