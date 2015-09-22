# ./copy_to_hadoop.sh --ssh_usr svcsftpuser ssh_key_file keys/etl_user.pem --source_server 10.20.10.71 --source_path /data/sftp/orionuser/incoming/ --source_file Active_test_2015_09_03.txt.gz --dest_path /tst/ --dest_file Active_unzipped1.txt
# --u = unzip
#ex:
# ./copy_to_hadoop.sh --ssh_usr svcsftpuser ssh_key_file keys/etl_user.pem --source_server 10.20.10.71 --source_path /data/sftp/orionuser/incoming/ --source_file Active_test_2015_09_03.txt.gz --dest_path /tst/ --dest_file Active_unzipped1.txt --u


ssh_usr=""
ssh_key_file=""
source_server=""
source_path=""
source_file=""
dest_path=""
dest_file=""
unzip="n"

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
                source_file)
                    source_file="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
#                    echo "Parsing option: '--${OPTARG}', value: '${source_file}'" >&2;
                    ;;
                dest_path)
                   dest_path="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
#                   echo "Parsing option: '--${OPTARG}', values: '${dest_path}'" >&2;
                   ;;
                dest_file)
                   dest_file="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
#                   echo "Parsing option: '--${OPTARG}', values: '${dest_file}'" >&2;
                   ;;
                u)
                  unzip="y"
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

echo "ssh_usr=$ssh_usr ssh_key_file=$ssh_key_file source_server=$source_server source_path=$source_path source_file=$source_file dest_path=$dest_path dest_file=$dest_file u=$unzip"


hadoop fs -rm -f $dest_path$dest_file
if [[ "$unzip" = "y" ]];
then
 echo "ssh  -i $ssh_key_file  $ssh_usr@$source_server cat $source_path$source_file | gunzip | hadoop fs -put - $dest_path$dest_file"
 ssh  -i $ssh_key_file  $ssh_usr@$source_server cat $source_path$source_file | gunzip | hadoop fs -put - $dest_path$dest_file
else
 echo "ssh  -i $ssh_key_file  svcsftpuser@$source_server cat $source_path$source_file | hadoop fs -put - $dest_path$dest_file"
 ssh  -i $ssh_key_file  $ssh_usr@$source_server cat $source_path$source_file | hadoop fs -put - $dest_path$dest_file
fi

if [ $? -eq 0 ]
then
  echo "File successfully copied"
  exit 0
else
  echo "Error copying file" >&2
  exit 255
fi