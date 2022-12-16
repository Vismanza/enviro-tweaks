#Data structured in InfluxDB

The various reading names are stored under \_measurement, then \_field value is 'value'.
The readings themselves are stored in \_value.

This means that in order to get a reading for a specific reading you need to filter on measurement:

    |> filter(fn: (r) => r._measurement == "aqi")
