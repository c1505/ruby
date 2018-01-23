class GildedRose
  attr_reader :items
  def initialize(items)
    @items = items
  end
  
  def update_quality
    @items.each do |item|
      case item.name
      when /Aged/
         Aged.new(item).day
      when /Sulfuras/
         item
      when /Backstage passes/
         Backstage.new(item).day
      when /Conjured/
         Conjured.new(item).day
      else
         Normal.new(item).day
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class Normal
  attr_reader :item
  def initialize(item)
    @item = item
  end
  
  def day
    item.quality -= 1
    item.quality -= 1 if item.sell_in <= 0
    item.quality = 0 if item.quality < 0
    item.sell_in -= 1
  end
end

class Conjured
  attr_reader :item
  def initialize(item)
    @item = item
  end
  
  def day
    item.quality -= 2
    item.quality -= 2 if item.sell_in <= 0
    item.quality = 0 if item.quality < 0
    item.sell_in -= 1
  end
end
require 'pry'
class Aged
  attr_reader :item
  def initialize(item)
    @item = item
  end
  
  def day
    item.quality += 1
    item.quality += 1 if item.sell_in <= 0
    item.quality = 50 if item.quality > 50
    item.sell_in -= 1
  end
end

class Backstage
  attr_reader :item
  def initialize(item)
    @item = item
  end
  
  def day
    item.quality += 1
    item.quality += 1 if item.sell_in <= 10
    item.quality += 1 if item.sell_in <= 5
    item.quality = 50 if item.quality > 50
    item.quality = 0 if item.sell_in <= 0
    item.sell_in -= 1
  end
end