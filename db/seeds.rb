require 'faker'

3.times do |u|
  user = User.create :email => "user#{u}@email.com", :password => 'password',
    :password_confirmation => 'password'
  print user.email

  3.times do |y|
    12.times do |m|
      10.times do |d|
        d = user.daily_records.create :transaction_date => (Date.today - y.year + m.month + d.day),
          :notes => Faker::Lorem.sentence, :budget => rand(1000)
        print '+'

        5.times do
          d.line_items.create :amount => rand(1000),
            :description => Faker::Lorem.sentence
          print '.'
        end
      end
    end
  end

  puts
end