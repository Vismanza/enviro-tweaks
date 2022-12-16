//Get all readings for specific sensor for the last 24 hours (at 15 minute intervals)
from(bucket: "smarthome")
    |> range(start: -24h)
    |> filter(
        fn: (r) =>
            r["_measurement"] == "aqi" or r["_measurement"] == "color_temperature" or r["_measurement"]
                ==
                "gas_resistance" or r["_measurement"] == "humidity" or r["_measurement"] == "luminance"
                or
                r["_measurement"] == "pressure" or r["_measurement"] == "temperature",
    )
    |> filter(fn: (r) => r["_field"] == "value")
    |> filter(fn: (r) => r["device"] == "main-bedroom-sensor")
    |> aggregateWindow(every: 15m, fn: mean, createEmpty: false)
    |> yield(name: "mean")