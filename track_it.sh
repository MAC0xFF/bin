#listing. track_it, отслеживания грузоотправителей
#!/bin/bash
PROGRAM=$(basename $0)
DATAFILE=packages.txt
BROWSER="opera"
errors=0
    cat "$DATAFILE" | while read line; do
    track=$(echo "$line" | awk '{print $1}')
    srv=$(echo "$line" | awk '{print $2}')
    case "$srv" in
        UPS) $BROWSER "https://www..=$track" & ;;
        FedEx) $BROWSER "https://www..=$track" & ;;
        USPS) $BROWSER "https://..=$track" & ;;
        *) >&2 echo "$PROGRAM: Unkn srv '$srv'" errors=1 ;;
    esac
done
exit $errors
#
#listing
<table id="ac">
    <thead>
        <tr>
            <th>Area code</th>
            <th>State</th>
            <th>Location</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ac">201</td>
            <td class="state">NJ</td>
            <td class="cities">Hackensack, Jersey City</td>
        </tr>
    </tbody>
</table>
#
areacode=’\([0-9]*\)’
state=’\([A-Z][A-Z]\)’
cities=’\([^@]*\)’
regexp=”$areacode@state@cities@”
replacement=’\1\t\2\t\3\n’
curl -s https://efficientlinux.com/areacodes.html \
| hxnormalize -x \
| hxselect -c -s'@' '#ac .ac, #ac .state, #ac .cities' \
| sed “s/$regexp/$replacement/g”
# sed 's/\([0-9]*\)@\([A-Z][A-Z]\)@\([^@]*\)@/\1\t\2\t\3\n/g'
