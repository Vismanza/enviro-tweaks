Get all readings for specific sensor

from(bucket: "smarthome")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "aqi" or r["_measurement"] == "color_temperature" or r["_measurement"] == "gas_resistance" or r["_measurement"] == "humidity" or r["_measurement"] == "luminance" or r["_measurement"] == "pressure" or r["_measurement"] == "temperature")
  |> filter(fn: (r) => r["_field"] == "value")
  |> filter(fn: (r) => r["device"] == "main-bedroom-sensor")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")
