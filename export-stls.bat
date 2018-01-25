openscad.exe -D "part=\"xt60\"" -D "flush=false" -o xt60-panelmount-protrude.stl XTconnector-panelmount.scad
openscad.exe -D "part=\"xt90\"" -D "flush=false" -o xt90-panelmount-protrude.stl XTconnector-panelmount.scad
openscad.exe -D "part=\"xt60\"" -D "flush=true" -o xt60-panelmount-flush.stl XTconnector-panelmount.scad
openscad.exe -D "part=\"xt90\"" -D "flush=true" -o xt90-panelmount-flush.stl XTconnector-panelmount.scad