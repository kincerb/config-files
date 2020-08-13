#!/usr/bin/env bash
script=$(basename $0)

convert_pdf() {
    # gs -o "${out_file}" -sDEVICE=pdfwrite -c "/setrgbcolor {pop pop pop 0 setgray} bind def" -f "${in_file}"
    # gs -o "${out_file}" -sDEVICE=pdfwrite -c "/osetcolor {/setcolor} bind def /setcolor {pop [0 0 0] osetcolor} def" \
    #     -f "${in_file}"
    gs -dNOPAUSE -dBATCH -q -sOutputFile="${out_file}" -sDEVICE=pdfimage8 -f "${in_file}"
}

print_help() {
    cat <<EOF >&2

Usage: ${script} --in-file String [ -o|--out-file String ]

Convert pdf to black and white.
           
Examples:
    ${script} --in-file /tmp/blah.pdf
    ${script} --in-file /tmp/color.pdf --out-file /tmp/bw.pdf

EOF
    exit 0
}

while :; do
    case $1 in
        -h|--help|-\?)
            print_help
            exit 0;;
        -i|--in-file)
            in_file="${2}"; shift 2;;
        -o|--out-file)
            out_file="${2}"; shift 2;;
        --) # End of all options
            shift; break;;
        -*)
            say Error "Unknown option (ignored): $1" >&2
            shift;;
        *) # No more options
            break;;
    esac
done

if [ -z "${in_file}" ]; then
    print_help
fi

if [ -z "${out_file}" ]; then
    out_file="${in_file}"
fi
convert_pdf
