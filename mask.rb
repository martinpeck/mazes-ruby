class Mask
    attr_reader :rows, :columns
    
    def initialize(rows, columns)
        @rows, @columns = rows, columns
        @bits = Array.new(@rows) { Array.new(@columns, true) }
    end
    
    def [](row, column)
        if row.between?(0, @rows - 1) && column.between?(0, @columns - 1)
            @bits[row][column]
        else
            false
        end
    end
    
    def []=(row, column, is_on)
        @bits[row][column] = is_on
    end
    
    def count
        count = 0
        
        @rows.times do |row|
            @columns.times do |col|
                count += 1 if @bits[row][col]
            end
        end
    end
    
    def random_location
        loop do
            row = rand(@rows)
            col = rand(@cols)
            
            return [row, col] if @bits[row][col]
        end
    end
end