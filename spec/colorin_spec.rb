require 'minitest/autorun'
require 'colorin'

describe Colorin do

  def assert_text(expected, text, action)
    assert_equal expected, Colorin.new(text).send(action)
  end

  it 'Text color' do
    assert_text "\e[31mtext\e[0m",       'text', :red
    assert_text "\e[32mtext\e[0m",       'text', :green
    assert_text "\e[33mtext\e[0m",       'text', :yellow
    assert_text "\e[38;5;220mtext\e[0m", 'text', :amber_500
    assert_text "\e[38;5;102mtext\e[0m", 'text', :grey_700
  end

  it 'Background color' do
    assert_text "\e[41mtext\e[0m",       'text', :on_red
    assert_text "\e[42mtext\e[0m",       'text', :on_green
    assert_text "\e[43mtext\e[0m",       'text', :on_yellow
    assert_text "\e[48;5;220mtext\e[0m", 'text', :on_amber_500
    assert_text "\e[48;5;102mtext\e[0m", 'text', :on_grey_700
  end

  it 'Style' do
    assert_text "\e[1mtext\e[0m", 'text', :bold
    assert_text "\e[4mtext\e[0m", 'text', :underline
    assert_text "\e[7mtext\e[0m", 'text', :negative
  end

  it 'Class methods' do
    assert_equal "\e[31mtext\e[0m", Colorin.red('text')
    assert_equal "\e[42mtext\e[0m", Colorin.on_green('text')
    assert_equal "\e[7mtext\e[0m",  Colorin.negative('text')
  end

  it 'Chained' do
    assert_equal "\e[4m\e[1m\e[44m\e[36mtext\e[0m\e[0m\e[0m\e[0m", Colorin.cyan('text').on_blue.bold.underline
  end

  it 'RGB' do
    assert_equal "\e[38;5;16mtext\e[0m", Colorin.new('text').rgb(10, 20, 30)
    assert_equal "\e[48;5;16mtext\e[0m", Colorin.new('text').on_rgb(10, 20, 30)
  end

  it 'Hexadecimal' do
    assert_equal "\e[38;5;149mtext\e[0m", Colorin.new('text').hex('a4b037')
    assert_equal "\e[48;5;149mtext\e[0m", Colorin.new('text').on_hex('a4b037')
  end

end