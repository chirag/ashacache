
From Hunts Controller Show:



From Hunts View Show: 


	
From Views Application Layout:




//--------------------------------------------------------------------------------\\

When creating hunts, I need the program to know who is logged in so the member field is filled in automatically.

If nobody is logged, in I need a message that says "You need to be logged in to do that"

</table>

// This was taken from the old hunts page.
<br />
<!--<p>By the way.  I'm an em-dash! <%# Maruku("I am a em-dash: —") %></p> -->
<p><%= textilize("i am _some_ — - & ® **text**") %></p>

Google Map Keys: 


old google header code: 

<body onload="load(<%= @hunt.latitude %>,<%= @hunt.longitude %>)" onunload="GUnload()"><!-- Google Maps -->


	  <script 
	src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAUPM_RV-PurJfr5f4ytMp8xQpDmmpk8q921mRIPG4qgOvy0T09hSVCLWIgEiN4XhRt-wAG-WtVOLjjg"
	    type="text/javascript">
		// Ashacache key: ABQIAAAAUPM_RV-PurJfr5f4ytMp8xQDelJeTuKxZ7NWHdsQXqZ70zaezRQ-4mvagmIcv6ydS_4pvLoV0p20cQ
		// Localhost key: ABQIAAAAUPM_RV-PurJfr5f4ytMp8xQpDmmpk8q921mRIPG4qgOvy0T09hSVCLWIgEiN4XhRt-wAG-WtVOLjjg
	</script>
	  <script type="text/javascript">

	  //<![CDATA[

	  function load(lat, long	) {
	    if (GBrowserIsCompatible()) {
	      var map = new GMap2(document.getElementById("map"));
	      map.setCenter(new GLatLng(lat, long), 10);
		 map.addControl(new GSmallMapControl());
		    map.addControl(new GMapTypeControl());
		    map.centerAndZoom(new GPoint(lat, long), 6);

		// Create a marker whose info window displays a message.
		function createMarker(point, html) {
		  var marker = new GMarker(point);

		  // What will the marker's say?
		  GEvent.addListener(marker, 'click', function() {
			marker.openInfoWindowHtml(html);
		  });
		  return marker;
		}

		// put the coordinates of Asheville landmark here:
		  var point = new GPoint(lat, long);
		  var html = '<div></div>';
		  var m1 = createMarker(point, html);
		  map.addOverlay(m1);


	    }
	  }

	  //]]>
	  </script>



	<div id="map" style="width: 400px; height: 400px"></div>
	
	
	from hunts update: 
	
	    
        if !params[:member][:new_password].blank?
          @member.password = Digest::SHA512.hexdigest @member .new_password
          @member.save
        end
    From the old Member login controller.

   if params[:name].length < 1 or params[:password].length < 1
     flash[:notice] = 'All fields must be filled' 
   else
     member = Member.find_or_create_by_name params[:name]
     if member.password == Digest::SHA512.hexdigest(params[:password])
       session[:member_id] = member.id  #Get rid of this. Put it in the model
     else
       flash[:notice] = 'User and password not found'
     end
   end
    redirect_to '/'
  end

