# rM-SSH-Upload

Upload a PDF to the reMarkable over SSH, useful for large PDFs that cause the web interface to hang or timeout

## How to use

- Copy the `rm_ssh_upload.sh` script to your reMarkable tablet
- Run a command on your computer using a Unix terminal that sends the PDF, and specifies and name for the file

```bash
cat "This is my file.pdf" | ssh root@reMarkable bash ./rm_ssh_upload.sh "'This is the file name I want it to have in my rM doc list'" `uuidgen`
```

>>> NOTE: The single quotes inside the double quotes are important and relevant for the version and behaviour of busybox on the reMarkable/ssh.
>>> 
