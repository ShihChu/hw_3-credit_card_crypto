# frozen_string_literal: true

require_relative 'credit_card'
require 'minitest/autorun'

module DoubleTranspositionCipher
    def self.row_swap(matrix,key)
      key.length.times do |i| 
        matrix[i], matrix[key[i]] = matrix[key[i]], matrix[i] if key[i] != i
        key[i], key[key[i]] = key[key[i]], key[i] if key[i] != i
      end
      matrix
    end
  
    def self.col_swap(matrix,key)
      #matrix.each { |row| row[i], row[j] = row[j], row[i]}
      matrix
    end
    
    def self.encrypt(document, key)
      # TODO: FILL THIS IN!
      ## Suggested steps for double transposition cipher
  
      # 1. find number of rows/cols such that matrix is almost square
      col_num_matrix = Math.sqrt(document.to_s.length).ceil
  
      # 2. break plaintext into evenly sized blocks
      matrix = document.to_s.chars
                  .each_slice(col_num_matrix)
                  .to_a
                  .tap{ |i| i.last.fill(" ", i.last.length, col_num_matrix - i.last.length) }
  
      # 3. sort rows in predictibly random way using key as seed
      # 4. sort columns of each row in predictibly random way
      Kernel.srand(key)
      row_swap_key = (0..matrix.length-1).to_a.sort_by{rand}

      Kernel.srand(key)
      col_swap_key = (0..matrix[0].length-1).to_a.sort_by{rand}

      matrix = row_swap(matrix,row_swap_key)
      matrix = col_swap(matrix,col_swap_key)
      
      # 5. return joined cyphertext
      encrpted_document = matrix.join
    end
  
    def self.decrypt(ciphertext, key)
      # TODO: FILL THIS IN!
      col_num_matrix = Math.sqrt(ciphertext.to_s.length).ceil
  
      de_matrix = ciphertext.to_s.chars
                            .each_slice(col_num_matrix)
                            .to_a
      Kernel.srand(key)
      row_swap_key = (0..de_matrix.length-1).to_a.sort_by{rand}.reverse
      Kernel.srand(key)
      col_swap_key = (0..de_matrix[0].length-1).to_a.sort_by{rand}.reverse

      de_matrix = col_swap(de_matrix,col_swap_key)
      de_matrix = row_swap(de_matrix,row_swap_key)
      decrpted_document = de_matrix.join.strip
    end
  end

#try
@cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
@key = 3

enc = DoubleTranspositionCipher.encrypt(@cc, @key)
#puts enc
dec = DoubleTranspositionCipher.decrypt(enc, @key)
#puts dec

a = [(0..2).to_a,(3..5).to_a,(6..8).to_a]
key = (0..2).to_a.sort_by{rand}
puts key.join
puts key.reverse.join
temp = DoubleTranspositionCipher.row_swap(a, key)
puts temp.join
temp = DoubleTranspositionCipher.row_swap(a, key.reverse)
puts temp.join
