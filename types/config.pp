# ulogd configuration with sections
type Ulogd::Config = Hash[
                       String[1], Hash[
                        String[1], Variant[String, Numeric, Boolean]
                       ]
]
