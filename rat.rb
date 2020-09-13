# E => Empty
# B => Block
# C => tTarget (cheese) 

@map = [
    ['E','B','B','B','B','E'],
    ['E','E','E','E','E','E'],
    ['E','B','B','B','B','E'],
    ['E','B','B','B','B','C'],
    ['E','B','B','B','B','E'],
    ['E','E','E','E','E','E'] 
]

@paths = [] # array to add the last movement
@success_paths = [] # array to save the success movement

def get_ways( point )
    # find the possible moves

    [0,1].each do |d| # 0 is for up or down, and 1 is for left or right
        the_point = point[d].to_i # select up-down or left-right, first or second key in array postiion
        [-1,1].each do |option| # add or less a step
            next_point = the_point + option
            if (option == -1 && next_point >= 0) || (option == 1 && next_point < @map.count)
                if d == 0 && @map[next_point][point[1].to_i] == 'E'
                    @paths.push( [next_point, point[1].to_i, (point[2].to_i + 1)] )
                end
                if d == 1 && @map[(point[0].to_i)][next_point] == 'E'
                    @paths.push( [point[0].to_i, next_point, (point[2].to_i + 1)] )
                end
            end
        end
    end

    # change the current point to "V" (visited)
    @map[(point[0].to_i)][point[1].to_i] = "V"

    # remove the current point from the array
    @paths.delete(point)
    
    # check if we are in the target point
    [0,1].each do |d| # 0 is for up or down, and 1 is for left or right
        the_point = point[d].to_i # select up-down or left-right, first or second key in array postiion
        [-1,1].each do |option| # add or less a step
            next_point = the_point + option
            if (option == -1 && next_point >= 0) || (option == 1 && next_point < @map.count)
                if d == 0 && @map[next_point][point[1].to_i] == 'C'
                    @success_paths.push( [next_point, point[1].to_i, (point[2].to_i + 1)] )
                end
                if d == 1 && @map[(point[0].to_i)][next_point] == 'C'
                    @success_paths.push( [point[0].to_i, next_point, (point[2].to_i + 1)] )
                end
            end
        end
    end

    @paths
end

start_point = [1,0,0] # position to begin. The last element saves the steps so it starts at zero
@paths = get_ways(start_point) # get the initial options to move

while @paths.count > 0 # as long as there are paths we see their possible movements from there
    @paths.each do |way| # for each move we evaluate if there are more or not, and if we area in the target point
        @paths = get_ways(way)
    end
end

if @success_paths.count > 0 # until we don't have more moves
    mins = @success_paths.map(&:last)
    print "the minimum steps to target is (are) => "+mins.min.to_s
else # If there was no path of success 
    print "No way :("
end