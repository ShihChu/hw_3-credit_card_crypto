module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    checkdigit = nums_a[-1]
    digits = nums_a.length - 1
    parity = nums_a.length % 2

    digits.times do |i|
      nums_a[i] *= 2 if i % 2 == parity
      nums_a[i] -= 9 if nums_a[i] > 9
    end

    (nums_a[0...digits].sum * 9) % 10 == checkdigit
  end
end
