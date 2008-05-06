task :greet do
puts "Hello World"
end

task :ask => :greet do 
  puts "How are you?"
end


namespace :show do
    desc "Show all the users"
   task :members => :environment do
        # ^ :environment automagically loads up your rails environment for you
        Member.find(:all).each { |u| puts u.name }
    end
  end
  

namespace :ashacache do
  desc "Pick a random User and Hunt"
  task :member => :environment do
    #member = Member.find(:first, :order => 'RAND()')
    #puts "Winner: #{member.name}"  /// Notice how it's easier to use the 'pick' method
    puts "Member: #{pick(Member).name}"
  end
  
  task :hunt => :environment do
    puts "Hunt: #{pick(Hunt).name}"
  end
  
  task :all => [:member, :hunt]
  
  def pick(model_class)
  model_class.find(:first, :order => 'RAND()')
  end
  
end

