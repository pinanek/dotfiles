function log
    set level $argv[1]
    set title $argv[2]
    set args $argv[3..-1]

    # pick color
    set log_color 0
    switch $level
        case debug
            set log_color 0
        case info
            set log_color 4
        case success
            set log_color 2
        case warn
            set log_color 3
        case error
            set log_color 1
        case fatal
            set log_color 5
        case '*'
            set log_color 0
    end

    set color_code (printf '\033[0;3%sm' $log_color)
    set no_color (printf '\033[0m')

    # %-7s padding, then uppercase
    set uppercase_level (printf '%-7s' $level | string upper)

    set timestamp (date "+%H:%M:%S")
    set formatted_message "$timestamp $color_code$uppercase_level$no_color $title $args"

    if contains -- $level warn error fatal
        printf '%s\n' "$formatted_message" >&2
    else
        printf '%s\n' "$formatted_message"
    end
end
