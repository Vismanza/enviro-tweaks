# enviro-tweaks
My collections of tweaks for getting [enviro]([url](https://github.com/pimoroni/enviro)) working for me. These boards are great and al real pleasure to learn with.

Currently I have changed the config from MQTT to Influx DB directly. Previously the data was being published to MQTT, picked up by Node Red and then pushed in to Influx. 

Home Assistant was using the data through MQTT. Now that MQTT is not being used the sensors need to reconfigured in HA to use Influx DB.

## Enclosures

I wanted an indoor enclosure that could print without supports and support minor customisation. I ended up with an openSCAD model that allows:
- Adding cutout text to the lid (it is for indoor! :-));
- Parametric setting of height, numbert of rings, angle of rings and diameter;
- Prints without supports;
- No screws needed

## Dashboards

Grafana page for:
- Indoor
- Urban

## Home Assistant

Document the config to have sensor state data sourced from Influx.
