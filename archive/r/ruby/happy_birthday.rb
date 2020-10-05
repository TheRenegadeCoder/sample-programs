if ARGV.length < 1
    puts "Usage: ruby happy_birthday.rb [NAME] [DAY/MONTH/YEAR] Example: ruby happy_birthday.rb Ramiro 05/10/2020"
else

    def say_happy_birthday(name, birthday)
      if birthday == Time.now.strftime("%d/%m/%Y")
        puts "Hi #{name}, Happy Birthday!!!!!"
      else
        puts "Hi #{name}, have a wonderful day :)"
      end
    end

    birthday = ARGV[1]
    name = ARGV[0]
    say_happy_birthday(name, birthday)
end
