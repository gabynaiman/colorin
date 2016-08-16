require 'minitest/autorun'
require 'colorin'

describe Colorin do

  def assert_text(expected, text, action)
    assert_equal expected, Colorin.new(text).send(action)
  end

  it 'Text color' do
    assert_text "\e[31mtext\e[0m", 'text', :red
    assert_text "\e[32mtext\e[0m", 'text', :green
    assert_text "\e[33mtext\e[0m", 'text', :yellow
  end

  it 'Background color' do
    assert_text "\e[41mtext\e[0m", 'text', :on_red
    assert_text "\e[42mtext\e[0m", 'text', :on_green
    assert_text "\e[43mtext\e[0m", 'text', :on_yellow
  end

  it 'Style' do
    assert_text "\e[1mtext\e[0m", 'text', :bold
    assert_text "\e[4mtext\e[0m", 'text', :underline
    assert_text "\e[7mtext\e[0m", 'text', :reverse
  end

  it 'Class methods' do
    assert_equal "\e[31mtext\e[0m", Colorin.red('text')
    assert_equal "\e[42mtext\e[0m", Colorin.on_green('text')
    assert_equal "\e[7mtext\e[0m",  Colorin.reverse('text')
  end

  it 'Chained' do
    assert_equal "\e[4m\e[1m\e[44m\e[36mtext\e[0m\e[0m\e[0m\e[0m", Colorin.cyan('text').on_blue.bold.underline
  end

end