candidate_prefs = {
            1=>[3,7,4,2,1,5,6],
            2=>[4,2,7,5,1,3,6],
            3=>[7,2,3,4,1,6,5],
            4=>[4,6,2,3,1,7,5],
            5=>[6,7,5,2,4,3,1],
            6=>[5,4,1,7,3,2,6],
            7=>[7,6,3,4,5,1,2]
        }
employer_prefs = {
    1=>[1,6,4,3,2,5,7],
    2=>[4,3,7,1,6,5,2],
    3=>[1,6,4,2,3,5,7],
    4=>[7,3,6,2,4,1,5],
    5=>[1,6,7,2,3,5,4],
    6=>[4,7,6,1,5,3,2],
    7=>[1,5,4,3,6,7,2]
}
# best for e, worst for c, where (e, c): (1, 2), (2, 3), (3, 1), (4, 7), (5, 6), (6, 4), (7, 5)
# if c could choose, where (c,e): (1, 3), (2, 1), (3, 2), (4, 6), (5, 7), (6, 5), (7, 4)
# reversing all preferences
#for a in candidate_prefs.keys
    #candidate_prefs[a] = candidate_prefs[a].reverse
    #employer_prefs[a] = employer_prefs[a].reverse
#end
# this means employers choose their worst pref
# (1, 7), (2, 6), (3, 5), (4, 1), (5, 4), (6, 2), (7, 3)
pairs = Hash.new # (employee=>candidate)
unmatched_candidates = candidate_prefs.keys
unmatched_employers = employer_prefs.keys
def getMatchedEmployer(pairs, candidate)
    for x,y in pairs
        if y == candidate
            return x
        end
    end
    nil
end
while !unmatched_employers.empty? do
    puts pairs
    # employer
    e = unmatched_employers.first 
    # candidate
    c = employer_prefs[e].shift
    # unmatched candidate
    if !pairs.value?(c)
        unmatched_employers.delete e 
        unmatched_candidates.delete c
        pairs[e] = c
        puts "matched employer #{e} with candidate #{c} (new)"
    else
        if candidate_prefs[c].index(e) < candidate_prefs[c].index(getMatchedEmployer(pairs, c))
            unmatched_employers.push(getMatchedEmployer(pairs, c))
            unmatched_employers.delete e 
            pairs.delete getMatchedEmployer(pairs, c)
            pairs[e] = c
            puts "matched employer #{e} with candidate #{c} (modified)"
        end
    end
end
for pair in pairs.sort
    print "(#{pair.first}, #{pair.last})"
    if pair != pairs.sort.last
        print ", "
    else
        puts
    end
end