#1/bin/bash

set -e

pdf_fname="$1"
pdf_docname=$(echo "$1" | tr -d '"')
document_uuid="$2"

echo "\"$pdf_docname\" \"$document_uuid\""

if [ $# -lt 2 ]
then
    echo "Must pass PDF name as arg 1, UUID as arg 2, and PDF body on stdin"
    exit 1
fi

cat - > "${document_uuid}.pdf"

metadata_body="{
    \"deleted\": false,
    \"lastModified\": \"`date -u +"%s"`000\",
    \"metadatamodified\": false,
    \"modified\": false,
    \"parent\": \"\",
    \"pinned\": false,
    \"synced\": true,
    \"type\": \"DocumentType\",
    \"version\": 1,
    \"visibleName\": \"${pdf_docname}\"
}"

content_body="{
    \"extraMetadata\": {
    },
    \"fileType\": \"pdf\",
    \"fontName\": \"\",
    \"lastOpenedPage\": 0,
    \"lineHeight\": -1,
    \"margins\": 100,
    \"orientation\": \"portrait\",
    \"pageCount\": 1,
    \"pages\": [
    ],
    \"textScale\": 1,
    \"transform\": {
        \"m11\": 1,
        \"m12\": 0,
        \"m13\": 0,
        \"m21\": 0,
        \"m22\": 1,
        \"m23\": 0,
        \"m31\": 0,
        \"m32\": 0,
        \"m33\": 1
    }
}"

pagedata_body=""

echo "$metadata_body" > "${document_uuid}.metadata"
echo "$content_body" > "${document_uuid}.content"
echo "$pagedata_body" > "${document_uuid}.pagedata"

for dir_suffix in "" ".cache" ".highlights" ".textconversion" ".thumbnails"
do
    mkdir "${document_uuid}${dir_suffix}"
done

mv $document_uuid.* /home/root/.local/share/remarkable/xochitl/
systemctl restart xochitl
