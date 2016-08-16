class Colorin < String

  VERSION = '1.0.0'

  CLEAR = 0
  
  CODES = {
    bold:             1,
    dark:             2,
    underline:        4,
    blink:            5,
    reverse:          7,
    hide:             8,

    black:            30,
    red:              31, 
    green:            32, 
    yellow:           33,
    blue:             34,
    magenta:          35,
    cyan:             36,
    white:            37,
    black_light:      90,
    red_light:        91, 
    green_light:      92, 
    yellow_light:     93,
    blue_light:       94,
    magenta_light:    95,
    cyan_light:       96,
    
    on_black:         40,
    on_red:           41, 
    on_green:         42, 
    on_yellow:        43,
    on_blue:          44,
    on_magenta:       45,
    on_cyan:          46,
    on_gray:          47,
    on_black_light:   100,
    on_red_light:     101, 
    on_green_light:   102, 
    on_yellow_light:  103,
    on_blue_light:    104,
    on_magenta_light: 105,
    on_cyan_light:    106,
    on_white:         107 
  }

  CODES.each do |name, value|
    define_method name do
      Colorin.new "\e[#{value}m#{self}\e[#{CLEAR}m"
    end

    define_singleton_method name do |string|
      Colorin.new(string).send name
    end
  end

end