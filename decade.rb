class String
  def ipv4?
    tokens = self.split(/\./)
    tokens.count == 4 && tokens.all? do |x|
      x.match(/^\d+$/) && x.to_i >= 0 && x.to_i < 256 && (x == "0" || !(x =~ /^0/))
    end
  end

  def ipv6?
    tokens = self.split(/:/)
    tokens.count == 8 && tokens.all? do |x|
      x =~ /^[0-9a-fA-F]+$/ && x.length <= 4 && (x == "0" || !(x =~ /^0/))
    end
  end

  def mac?
    separator = self =~ /-/ ? /-/ : /:/
    tokens = self.split(separator)
    tokens.count == 6 && tokens.all? do |x|
      x =~ /^[0-9a-fA-F]{2}$/
    end
  end

  def other?
    !(ipv4? || ipv6? || mac?)
  end

end

class Game
  def initialize(lines)
    @lines = lines.map(&:strip)
  end

  def tokens
    @lines.map do |x|
      case
      when x.ipv4?
        '01'
      when x.ipv6?
        '10'
      when x.mac?
        '00'
      else
        '11'
      end
    end
  end

  def byte_strings
    tokens.join.split(/(.{8})/).select{|x| x != '' }
  end

  def char_ints
    byte_strings.map{|x| x.to_i(2) }
  end

  def str
    char_ints.map(&:chr).join
  end
end
