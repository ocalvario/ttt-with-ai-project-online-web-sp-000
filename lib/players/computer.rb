require('pry')

module Players
  class Computer < Player
    def move(board)
      valid_moves = ["1","2","3","4","5","6","7","8","9"].select {|m| board.valid_move?(m)} # only check valid moves
      scores = valid_moves.collect {|i|  [i,score_move(i,board)]}
      sorted = scores.sort {|i,j| j[1] <=> i[1]} # sort the scores by score
      sorted[0][0] # return the move with the highest score
    end

    def score_move(position,board)
      score = 0
      relevant_combos = Game::WIN_COMBINATIONS.select{|c| c.include?(position.to_i-1)}
      relevant_combos.each do |combo|
        tokens=["#{board.cells[combo[0]]}", "#{board.cells[combo[1]]}", "#{board.cells[combo[2]]}"]
        score+=score_combo(tokens)
      end
      score
    end

    def score_combo(tokens)
      mine = tokens.count(self.token)
      theirs = tokens.count(self.opponent_token)
      blanks = tokens.count(" ")
      if blanks==0  then return 0
      elsif mine==2 then return 7
      elsif theirs==2 then return 6
      elsif mine==1 && blanks==2 then return 3
      elsif blanks == 3  then return 2
      elsif theirs==1 && blanks==2 then return 1
      else return 0
      end
    end
  end
end