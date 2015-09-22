#ex:
# ./copy_to_s3.sh --ssh_usr scvsftpuser --ssh_key_file keys/etl_usr.pem --source_server 10.20.10.71 --source_path /data/sftp/orionuser/incoming/ --source_file Active_test_2015_09_03.txt.gz --dest_path //cidx-ftp-archive/test/  --dest_file Active_test_2015_09_03.txt.gz

ssh_usr=""
ssh_key_file=""
source_server=""
source_path=""
source_file=""
dest_path=""
dest_file=""

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

echo ssh_usr=$ssh_usr ssh_key_file=$ssh_key_file "source_server=$source_server source_path=$source_path source_file=$source_file dest_path=$dest_path dest_file=$dest_file"


echo "ssh  -i ssh_key_file  $ssh_usr@$source_server cat $source_path$source_file | aws s3 cp - s3:$dest_path$dest_file"
ssh  -i ssh_key_file  $ssh_usr@$source_server cat $source_path$source_file | aws s3 cp - s3:$dest_path$dest_file

if [ $? -eq 0 ]
then
  echo "File successfully copied to S3"
  exit 0
else
  echo "Error copying file to S3" >&2
  exit 255
fi
