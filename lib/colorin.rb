require 'yaml'

class Colorin < String

  configuration = YAML.load_file File.join(File.dirname(__FILE__), 'configuration.yml')
  
  VERSION = '2.0.0'

  STYLES = configuration[:styles].freeze

  DEFAULT_COLORS = configuration[:default_colors].freeze

  CUSTOM_COLORS = configuration[:custom_colors].freeze

  [STYLES, DEFAULT_COLORS].each do |config|
    config.each do |name, value|
      define_method name do
        wrap value
      end

      define_singleton_method name do |string|
        Colorin.new(string).send name
      end
    end
  end

  CUSTOM_COLORS.each do |name, value|
    define_method name do
      hex value
    end

    define_method "on_#{name}" do
      on_hex value
    end

    define_singleton_method name do |string|
      Colorin.new(string).send name
    end

    define_singleton_method "on_#{name}" do |string|
      Colorin.new(string).send "on_#{name}"
    end
  end

  def rgb(r, g, b)
    wrap "38;5;#{rgb_to_256(r, g, b)}"
  end

  def on_rgb(r, g, b)
    wrap "48;5;#{rgb_to_256(r, g, b)}"
  end

  def hex(hex)
    rgb *hex_to_rgb(hex)
  end

  def on_hex(hex)
    on_rgb *hex_to_rgb(hex)
  end

  def self.color_palette
    DEFAULT_COLORS.keys.reject { |c| c.to_s.start_with? 'on_' }.map { |color| "#{Colorin.send "on_#{color}", '    ' }  #{Colorin.send color, color.to_s}" }
  end

  def self.custom_color_palette
    CUSTOM_COLORS.keys.map { |color| "#{Colorin.send "on_#{color}", '    ' }  #{Colorin.send color, color.to_s}" }
  end

  private

  def wrap(code)
    Colorin.new "\e[#{code}m#{self}\e[#{STYLES[:clear]}m"
  end

  def hex_to_rgb(hex)
    raise ArgumentError, "Invalid hexadecimal: #{hex}" unless hex.match /[0-9abcdef]{6}/i
    [
      hex[0,2].to_i(16),
      hex[2,2].to_i(16),
      hex[4,2].to_i(16),
    ]
  end

  def rgb_to_256(r, g, b)
    raise ArgumentError, "Color out of range (0-255): r: #{r}, g: #{g}, b: #{b}" if [r,g,b].any? { |c| c < 0 || c > 255 }
    red, green, blue = [r, g, b].map { |c| (6 * (c / 256.0)).to_i }
    (red * 36 + green * 6 + blue + 16).abs
  end

end