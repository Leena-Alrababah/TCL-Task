set fileHandle [open "input.txt" r]

set stringCount 0
set oddNumberCount 0
set evenNumberCount 0
set invalidCount 0

set sum 0
set sum2 0  
set concatString ""
set concatenatedLineCount 0

set maxIntValue [expr {double("-inf")}]
set minLength 1000

set lineNumber 0
while {[gets $fileHandle line] != -1} {
    incr lineNumber

    if {[regexp {^[A-Za-z]} $line] || [regexp {^\d+\.\d+$} $line]} {
        puts "LINE $lineNumber: $line (length = [string length $line])"
        incr stringCount

        if {$concatenatedLineCount < 3} {
            append concatString "$line "
            incr concatenatedLineCount
        }
    } else {
        if {[string is integer -strict $line]} {
            set intValue [expr {$line % 2 ? $line / 2 : $line * 3.25}]

            if {$intValue > $maxIntValue} {
                set maxIntValue $intValue
            }

            if {![string is space $line] && [string length $line] < $minLength} {
                set minLength [string length $line]
            }

            if {$line % 2 == 1} {
                puts "LINE $lineNumber: $intValue"
                incr oddNumberCount
            } else {
                puts "LINE $lineNumber: [format "%.2f" $intValue]"
                incr evenNumberCount
            }

            if {[string is integer -strict $line] && $sum == 0} {
                set sum $line
            } elseif {[string is integer -strict $line] && $sum != 0 && $sum2 == 0} {
                set sum2 $line
            }
        } else {
            puts "LINE $lineNumber: INVALID LINE"
            incr invalidCount
        }
    }
}

puts "Summary report:"
puts "Number of lines containing string: $stringCount"
puts "Number of lines with odd integers: $oddNumberCount"
puts "Number of lines with even integers: $evenNumberCount"
puts "Number of invalid lines: $invalidCount"
puts "Sum of the first two integers: [expr {$sum + $sum2}]"
puts "Concatenation of the first three lines starting with string characters: [string trim $concatString]"
puts "Maximum integer value: $maxIntValue"
puts "Minimum length of non-empty string: $minLength"

close $fileHandle
