require File.dirname(__FILE__) + '/../spec_helper'

describe Hunt do

  def valid_hunt_attributes options = {}
    {
      :name         => 'Find the thing',
      :directions   => 'Follow the leader',
      :description  => 'This one if _so_ **fun!**',
      :difficulty   => 'easy',
      :location     => 'Someplace, USA',
      :length       => '1.0',
      :view_level   => 10
    }.merge options
  end

  it 'should be valid with valid_hunt_attributes' do
    Hunt.new( valid_hunt_attributes ).should be_valid
  end

end
