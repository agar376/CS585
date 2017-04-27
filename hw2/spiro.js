// Using JS to create KML in console using the description and formulas given in HW
// description for the spiro graph

// R = 5, r = 1, a = 4
// x(t) = (R+r)*cos((r/R)*t) - a*cos((1+r/R)*t)
// y(t) = (R+r)*sin((r/R)*t) - a*sin((1+r/R)*t)

// Used some code from HW description

var kml = "";
var x_coord = 34.021224;
var y_coord = -118.289304;

kml += '<?xml version="1.0" encoding="UTF-8"?>';
kml += "\n";
kml += '<kml xmlns="http://www.opengis.net/kml/2.0">';
kml += "\n";


kml += '<Document>';
kml += "\n";
kml += '<Style id="dot"><IconStyle><Icon><href>http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png</href></Icon></IconStyle></Style>';
kml += "\n";
kml += '<Style id="spiral"><IconStyle><Icon><href>http://www.google.com/intl/en_us/mapfiles/ms/micons/red-dot.png</href></Icon></IconStyle></Style>';
kml += "\n";
kml += '<Placemark><styleUrl>#dot</styleUrl><name>SGM 123</name><Point>';
kml += '<coordinates>' + y_coord + ',' + x_coord + '</coordinates>';
kml += '</Point></Placemark>';
kml += "\n";

var R = 5, r = 1, a = 4;
var x0 = (R + r - a), y0 = 0;
var cos = Math.cos;
var sin = Math.sin;
var pi = Math.PI;
var nrev = 10;
for (var t = 0.0; t < (pi*nrev); t += 0.01) {
    kml += '<Placemark><name></name><styleUrl>#spiral</styleUrl><Point><coordinates>';
    var x = (R+r)*cos((r/R)*t) - a*cos((1+r/R)*t);
    var y = (R+r)*sin((r/R)*t) - a*sin((1+r/R)*t);

    kml += (y + y_coord) + ',' + (x + x_coord);
    kml += '</coordinates></Point></Placemark>';
    kml += "\n";
}

kml += '</Document></kml>';

console.log(kml);
