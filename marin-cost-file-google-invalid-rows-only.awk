# Totals up the cost data for all "valid" rows.
# Valid rows are those with a non-empty mkwid (Marin keyword id).

BEGIN {
    missing_cost = 0;
    total_cost = 0;
    output_file = "chickens.csv";
}

NR == 1
{
    print "============================"
    printf "/23144so16872/exports/%s\n", FILENAME
    print "----------------------------"
    print "Invalid rows\n----------------";
}

# Print the header row
NR == 6
{
    print $0;
}

# If we're after line 6 (header row)
# If the line is not empty
# If this row pertains to a Google account
NR > 6 && NF > 0 && $3 == "Google"
{
    total_cost += $9;

    # Validate the tracking ID
    if ($4 ~! /^$/)
    {
        print $0;
        missing_cost += $9;
    }
}

END {
    print "----------------"
    printf "Total cost data is $%5.2f.\n", total_cost;
    printf "Missing cost data is $%5.2f.\n", missing_cost;
    printf "Data inserted into DB is $%5.2f.\n", total_cost - missing_cost;
    print "============================"
    print "\n"
}
