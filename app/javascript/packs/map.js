//  let map


document.addEventListener("DOMContentLoaded", () => {
  const script = document.createElement("script")
  script.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyCWCa5GDZBE09G610gyGsIi4akQup_x7qQ&callback=initMap"
  script.async = true
  const mapEl = document.querySelector("#map")

  const initializeMap = () => {
    return new google.maps.Map(mapEl, {
      center: {lat: mapEl.dataset.lat, lng: mapEl.dataset.lng},
      zoom: 15,
      zoomControl: false,
      mapTypeControl: false,
      fullscreenControl: false,
      streetViewControl: false,
    });
  }

  function initMap(){
    geocoder = new google.maps.Geocoder()

    const map = initializeMap()
    marker = new google.maps.Marker({
      position: {lat: mapEl.dataset.lat, lng: mapEl.dataset.lng},
      map: map
    });
  }



  function codeAddresscd (){
    let inputAddress = document.getElementById('address').value;

    geocoder.geocode( { 'address': inputAddress}, function(results, status) {
      const map = initializeMap()
      if (status == 'OK') {
        map.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
        });
        display.textContent = "検索結果：" + results[ 0 ].geometry.location
      } else {
        alert('該当する結果がありませんでした：' + status);
      }
    });
  }

  document.head.appendChild(script)
})