function 0x0 --wraps="0x0" --description="Quick file upload to 0x0.st (up to 512 MiB)"
    curl -F "file=@$argv" https://0x0.st
end
