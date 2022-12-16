from(bucket: "smarthome")              // ── Source
    |> range(start: -1d)                    // ── Filter on time
    |> filter(fn: (r) => r._measurement == "aqi") // ── Filter on column values
    |> group(columns: ["device"])         // ── Shape
    |> mean()                               // ── Process