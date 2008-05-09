# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

namespace :ubuntu do
  desc "Install Ubuntu dependencies"
  task :install_dependencies do
    puts "Packages to install:"
    packages = { 
      'build-essential'     => 'Required for building native extensions',
      'ruby1.8-dev'         => 'Required for building native extensions',
      'libsqlite3-dev'      => 'Required for building sqlite-ruby gem',
      'libsqlite3-ruby1.8'  => 'Required for building sqlite-ruby gem'
    }
    packages.each { |pkg, why| puts " - #{ pkg }:  #{ ' ' * (20-pkg.to_s.length) }#{ why }" }
    puts "Installing packages, please be patient ..."
    puts "[ sudo aptitude install -y #{ packages.keys.join ' ' } ]"
    puts `sudo aptitude install -y #{ packages.keys.join ' ' }`
  end
end

# Rails 2.1 will add gem dependencies, so this task will be automatically
# added and gem dependencies will be defined in config/environment.rb
#
# remove this when Rails is 2.1 and convert these to 'gem dependencies'
namespace :gems do
  desc "Install gem dependencies"
  task :install do
    puts "Gems to install:"
    gems = { 
      :rails            => 'Required to run application',
      'sqlite3-ruby'     => 'Required to run the development database',
      :maruku           => 'For rendering Markdown (lightweight markup)',
      :ferret           => 'For full-text searching',
      'acts_as_ferret'  => 'ActiveRecord plugin for searching using ferret',
      :mongrel          => 'Faster development server than Webrick (default)'
    }
    gems.each { |gem, why| puts " - #{ gem }:  #{ ' ' * (15-gem.to_s.length) }#{ why }" }
    puts "Installing gems, please be patient ..."
    puts "[ sudo gem install #{ gems.keys.join ' ' } ]"
    puts `sudo gem install #{ gems.keys.join ' ' }`
  end
end
