#!/bin/bash

ssh_usr=""
ssh_key_file=""
source_server=""
source_path=""
file_mask=""

optspec=":t:ic-:"
while getopts "$optspec" optchar; do
        case "${optchar}" in
        -)
            case "${OPTARG}" in
                ssh_usr)
                    ssh_usr="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
#                    echo "Parsing option: '--${OPTARG}', value: '${ssh_usr}'" >&2;
                    ;;
                ssh_key_file)
                    ssh_key_file="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
#                    echo "Parsing option: '--${OPTARG}', value: '${ssh_key_file}'" >&2;
                    ;;
                source_server)
                    source_server="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
#                    echo "Parsing option: '--${OPTARG}', value: '${source_server}'" >&2;
                    ;;
                source_path)
                    source_path="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
#                    echo "Parsing option: '--${OPTARG}', value: '${source_path}'" >&2;
                    ;;
                file_mask)
                    file_mask="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
#                    echo "Parsing option: '--${OPTARG}', value: '${file_mask}'" >&2;
                    ;;

                *)
                    if [ "$OPTERR" = 1 ] && [ "${optspec:0:1}" != ":" ]; then
                        echo "Unknown option --${OPTARG}" >&2
                    fi
                  ;;
            esac;;

        *)
            if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" = ":" ]; then
                echo "Non-option argument: '-${OPTARG}'" >&2
            fi
            ;;
    esac
done

# echo "ssh_usr=$ssh_usr ssh_key_file=$ssh_key_file source_server=$source_server source_path=$source_path file_mask=$file_mask"

# echo "ssh -i $ssh_key_file $ssh_usr@$source_server ls $source_path$file_mask | xargs -n 1 basename"
output="$(ssh -i $ssh_key_file $ssh_usr@$source_server ls $source_path$file_mask | xargs -n 1 basename)"
# echo "$output"
if [ $? -eq 0 ]
then
  echo "$output"
else
  echo "255" >&2
  exit 255
fi
