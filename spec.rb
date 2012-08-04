require_relative 'decade'
describe String do

  describe :ipv4? do
    {"19.232.98.2" => true, "100.200.100.300" => false}.each do |token, type|
      describe token do
        subject { token }
        case type
        when true
          it { should be_ipv4 }
        when false
          it { should_not be_ipv4 }
        end
      end
    end
  end

  describe :ipv6? do
    {"2001:1234:3210:ABCD:9876:3232:3812:FFAB" => true, "0:2000:11:1:2:3:211:10" => true, "1:2:3:4:5:6:07:8" => false, "2001:db8:bd05:1d2:288a:1fc0:1:10ee" => true}.each do |token, type|
      describe token do
        subject { token }
        case type
        when true
          it { should be_ipv6 }
        when false
          it { should_not be_ipv6 }
        end
      end
    end
  end

  describe :mac? do
    {"00:11:22:33:44:55" => true, "1A-B2-c3-d4-e5-f6" => true, "2a:2b-40-54:10-01" => false}.each do |token, type|
      describe token do
        subject { token }
        case type
        when true
          it { should be_mac }
        when false
          it { should_not be_mac }
        end
      end
    end
  end
end

describe Game do
  let(:input) { <<_END_
192.168.0.23
00:00:01:22:23:34
FF:DD:BB:AA:CC:EE
2001:db8:bd05:1d2:288a:1fc0:1:10ee
123.45.67.89
12:34:56:78:9a:bc
1A-2B:2E-09:12:22
300.100.200.10
10.232.33.44
90-12-03-92-00-01
01234:22:4444:34:5555:5:f
0.100.32.10
100.200.100.200
10:20:30:01:02:03
11-22-33-44-55-66
9f34:234:1:123:45:6:FFFF:FFF
_END_
  }
  subject { @game }
  before do
    @game = Game.new(input.lines.to_a)
  end
  its(:tokens) { should == %w{01 00 00 10 01 00 11 11 01 00 11 01 01 00 00 10} }
  its(:byte_strings) { should == %w{01000010 01001111 01001101 01000010} }
  its(:char_ints) { should == [0x42, 0x4f, 0x4d, 0x42] }
  its(:str) { should == "BOMB" }
end
