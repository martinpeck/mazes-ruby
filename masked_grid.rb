require_relative 'grid'

class MaskedGrid < Grid
    attr_reader :mask
    
    def initialize(mask)
        @mask = mask
        super(@mask.rows, @mask.columns)
    end
    
    def prepare_grid
        Array.new(rows) do |row|
            Array.new(columns) do |col|
                Cell.new(row, col) if @mask[row, col]
            end
        end
    end
    
    def random_cell
        row, col = @mask.random_location
        self[row,col]
    end
    
    def size
        @mask.count
    end
    
end