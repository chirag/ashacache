
class Hunt < ActiveRecord::Base
  
  # A Hunt can have many comments
  has_many :comments

  # A Member can have many hunts.
  belongs_to :member

  # A Hunt has one image.
  has_one :image , :conditions => 'parent_id is null'
 
  # These are attribute accessors. They allow the object to work with fields
  # that are not in the database
  attr_accessor :latitude_north_south
  attr_accessor :latitude_degree
  attr_accessor :latitude_minute
  attr_accessor :latitude_second

  attr_accessor :longitude_east_west
  attr_accessor :longitude_degree
  attr_accessor :longitude_minute
  attr_accessor :longitude_second
  
  # Basic form validation
  validates_presence_of :name, :message => "Please add a title."
  validates_presence_of :location, :message => "Please add a location"
  validates_presence_of :length, :message => "Please choose a length"
  validates_presence_of :difficulty, :message => "Please choose a difficulty"
  validates_presence_of :description, :message => "Please choose a description"
  validates_presence_of :directions, :message => "Please give brief direction to the trail head"
  validates_presence_of :view_level, :message => "Please choose a view level"
  
  # validates_numericality_of  :latitude_degree, :message => "Please enter a valid number"
  # validates_numericality_of  :latitude_minute, :message => "Please enter a valid number"
  # validates_numericality_of  :latitude_second, :message => "Please enter a valid number"
  # validates_numericality_of  :longitude_degree, :message => "Please enter a valid number"
  # validates_numericality_of  :longitude_minute, :message => "Please enter a valid number"
  # validates_numericality_of  :longitude_second, :message => "Please enter a valid number"
  
      validates_length_of :longitude_second, :in => 1..60, :allow_blank => true , :message=> "seconds must be less than 60"
  
  


  # Does a hunt have comments? How do you know to show them?
  def has_comments? # the has_comments? method from Rails 1.* doesn't work anymore
    !comments.nil?
  end

  # This builds the Google Map instnace and div using the YM4R plugin.
  def map
    @map = GMap.new("map_div")
    @map.control_init(:large_map => true,:map_type => true)
    @map.center_zoom_init([latitude,longitude],view_level)
    @map.overlay_init(GMarker.new([latitude,longitude],:title => 'hi' , :info_window => assemble_map_div))
    @map
  end

  def assemble_map_div
    # This was added specifically to prevent an error when no image was present for the pop up.
    if image # is there an image?
     popup_image = image.public_filename.to_s 
    else
     popup_image = "#"
    end
    
    # Now that you know if we have an image or not, write out the HTML for the map div.
    map_div = "<div   style='height:\'100px\';width:\'50px\''><h1 style='font-size:15px;color:#4C1B1B;padding:0;margin:0 0 5px 0'>" + name.to_str + "</h1><img src='" +     popup_image + "' height=\'100px\' vspace=\'5px\' /></div>"
  end

  # The next four methods are used to take the decimal representation of the map coordinates and
  # convert it back to DD:MM:SS format.
  def latitude_degree_display
    decimal_to_degrees latitude, 'string', 'lat'
  end

  def longitude_degree_display
    decimal_to_degrees longitude, 'string','lon'
  end

  def decimal_to_degrees decimal, return_type, lat_or_lon # decimal conversion (i.e. in 121.135°) 
      degree_minute = decimal.to_s.split "."
      degree = degree_minute[0].to_i # The whole units of degrees will remain the same (i.e. 121)
      minute_second = ((("." + degree_minute[1]).to_f) * 60).to_s.split "."  #Multiply the decimal by 60 (i.e. .135 * 60 = 8.1).
      minute = minute_second[0] #The whole number becomes the minute (i.e. 8').
   second = (("." + minute_second[1]).to_f * 60).to_s #Take the remaining decimal and multiply by 60. (i.e. .1 * 60 = 6). 
   # One last thing to figure out? N, S, W or E?
    if  lat_or_lon == 'lat'
     if decimal < 0
       compass = 'S'
     else
       compass = 'N'
     end
   elsif lat_or_lon == 'lon'
     if decimal < 0
       compass = 'W'
     else
       compass = 'E'
     end
   end

   # Take your three sets of numbers and put them together, 
   # using the symbols for degrees (°), minute (‘), and second (') (i.e. 121°8'6' longitude)  
   if return_type == 'string'
     return  compass + ' ' + (degree.abs).to_s + "° " + minute + "‘ " + second + "'"
   elsif return_type == 'degree'
     return (degree.abs).to_s
   elsif return_type == 'minute'
     return minute
   elsif return_type == 'second'
     return second
   elsif return_type == 'compass'
      return compass
   end    
 end
 
  # Begin the converstion process from decimal coordinates to DD:MM:SS format.
  def prepare_lon_lat_for_edit
   self.latitude_north_south = decimal_to_degrees latitude, 'compass', 'lat'

   self.latitude_degree =  decimal_to_degrees latitude, 'degree', 'lat'

   self.latitude_minute =  decimal_to_degrees latitude, 'minute', 'lat'

   self.latitude_second = decimal_to_degrees latitude, 'second', 'lat'

   self.longitude_east_west = decimal_to_degrees longitude, 'compass', 'lon'

   self.longitude_degree = decimal_to_degrees longitude, 'degree', 'lon'

   self.longitude_minute = decimal_to_degrees longitude, 'minute', 'lon'

   self.longitude_second = decimal_to_degrees longitude, 'second', 'lon'
  end
 
  # These two mehtods are 'call backs'  The run after the object is created.
  # The reason I'm using call backs is because I need to convert 
  # the input of DD:MM:SS format into decimal form.
  def after_validation_on_create
    degrees_to_decimal
  end
  
  def after_validation_on_update
    degrees_to_decimal
  end
  
  # This mehtod is used in the very beginning when hunt is created
  # The Google Map API needs a decimal format, but the form sends a DD:MM:SS format
  # to be more user friendly to humans.
  # What Google Maps wants: 37.4419, -122.1419  /// Converts to N 37° 26.514 W 122° 08.514
  def degrees_to_decimal
    if errors.length == 0 # make sure it's valid ... no validation errors
    # Set the latitude varible be concatenating the values of DD:MM:SS
    lat =  latitude_north_south.to_i + latitude_degree.to_f  + latitude_minute.to_f / 60 + latitude_second.to_f / 3600
      if latitude_north_south == 'S'
        self.latitude =  lat * -1
      else
        self.latitude = lat
      end
      # Set the longitude varible to be concatenating the values of DD:MM:SS
      lon = longitude_east_west.to_i + longitude_degree.to_f  + longitude_minute.to_f / 60 + longitude_second.to_f / 3600
    if longitude_east_west == 'W'
      self.longitude = lon * -1
    else
      self.longitude = lon
    end
    end
  end
        
  # Acts as ferret is a plug in that allows a model to be serched. It uses index
  # files found in the '/index' directory
  acts_as_ferret :fields => [:name, :description]

  # PROBABLY TRASH
  # def self.coordinates_from_parts parts
  #   return parts
  # end
  
end
