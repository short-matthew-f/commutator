require 'rspec'
require 'letter'

describe Letter do
  let(:x_0) { Letter.new("x_0") }
  let(:x_10) { Letter.new("x_1^0") }
  let(:x_14) { Letter.new("x_1^4") }

  describe '#to_s' do
  
    it 'returns a string' do
      expect(x_14.to_s).to be_a(String)
    end
    
    it "returns a no exponent if exp = 1" do
      expect(x_0.to_s).to eq("x_0")
    end
    
    it 'returns an empty string if exp = 0' do
      expect(x_10.to_s).to eq("")
    end
    
    it 'returns something of the form x_5^12' do
      expect(x_14.to_s).to eq("x_1^4")
    end
  
  end

  describe '#to_latex' do
    
    it 'should have curly braces' do
      expect(x_0.to_latex).to eq("x_{0}")
    end
    
    it 'should be empty if exp = 0' do
      expect(x_10.to_latex).to eq('')
    end
    
  end

  describe '#lower_index!' do
    it 'should raise an error if index < 1' do
      expect do
        x_0.lower_index!
      end.to raise_error("Can't have negitive index")
    end
    
    it 'should lower the index by 1' do
      test_letter = x_14.lower_index!
      new_index = test_letter.index
      expect(new_index).to eq(0)
    end
  end

  describe '#raise_index!' do
    it 'should raise the index by 1' do
      test_letter = x_0.raise_index!
      new_index = test_letter.index
      expect(new_index).to eq(1)
    end
  end

  describe '#invert!' do
    it 'should negate the exponent' do
      test = x_14.invert!
      expect(test.exp).to eq(-4)
    end
  end

  describe '#invert' do
    it 'should return the inverse, but not change the orginal' do
      test = x_14.invert
      expect(test.exp).to eq(-4)
      expect(test).to_not eq(x_14)
    end
  end

  describe '#==' do
    it 'should return true when letters are equal (but different instances)' do
      letter = Letter.new("x_1^4")
      expect(x_14 == letter).to be_true
    end
    
    it 'should return false with different exponets' do
      letter = Letter.new("x_1")
      expect(letter == x_14).to be_false
    end
    
    it 'should return false with different indexs' do
      letter = Letter.new("x_1")
      expect(letter == x_0).to be_false
    end
  end

  describe '#inverse?' do
    it 'should return true if index is the same, and exponent inverses different' do
      letter = Letter.new("x_0^-1")
      expect(x_0.inverse?(letter)).to be_true
    end
    
    it 'should return false if the index is the same, and the exponents not inverses' do
      expect(x_0.inverse?(x_0)).to be_false
    end
    
    it 'should return false if different index' do
      letter = Letter.new("x_1")
      expect(x_0.inverse?(letter)).to be_false
    end
  end

  describe '#neg?' do
    it 'should return true if exp is less than 0' do
      letter = Letter.new("x_1^-1")
      expect(letter.neg?).to be_true
    end
    
    it 'should return false if exp is greater than 0' do
      expect(x_0.neg?).to be_false
    end
  end

  describe '#pos?' do
    it 'should return true if exp is greater than 0' do
      expect(x_0.pos?).to be_true
    end
    
    it 'should return false if exp is less than 0' do
      letter = Letter.new("x_1^-1")
      expect(letter.pos?).to be_false
    end
  end
end